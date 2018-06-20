# hostcamo

This is [my hostfile](https://gitlab.com/fengb/hostcamo/-/jobs/artifacts/master/raw/dist/hosts?job=hosts). There are many like it, but this one is mine.

## Major features

* Tiny script — less code is easier to audit
* Leverages git history — easier to track changes
* [Pi-Hole adlist](https://raw.githubusercontent.com/pi-hole/pi-hole/master/adlists.default) — good enough for me

## How to use

#### Sample OpenVPN server — test only, insecure

_Do not trust random VPN servers (including this one); they can easily MITM any network request you make._

1. Download the [OpenVPN profile](https://gitlab.com/fengb/hostcamo/uploads/0c3d0ce1865282788fb0a30a96f9222f/hostcamo-example.ovpn) — SHA256 4748fc7513e5175b71f49f5bbbbe0292242da3e2ab59c5afa4c5f277593547df
2. Connect using your favorite OpenVPN client — I use [Tunnelblick for macOS](https://tunnelblick.net/) and [OpenVPN Connect for iOS](https://itunes.apple.com/us/app/openvpn-connect/id590379981)
3. Verify it's working: `nslookup doubleclick.net`
4. Disconnect, because why are you connecting to a random VPN?

#### OpenVPN using Docker

```bash
# Use a volume to persist the VPN config
$ docker volume create openvpn

# Start the server -- first boot is slow because it generates an OpenVPN config
$ docker run --volume openvpn:/etc/openvpn --env OVPN_SERVER_NAME=[your-hostname] --name hostcamo --detach --publish-all registry.gitlab.com/fengb/hostcamo

# Get the client profile
$ docker exec hostcamo ovpn_getclient hostcamo > hostcamo.ovpn
```

## IP address discussion

I have tinkered with a few "black hole" IP addresses, but none of them work
perfectly in IPv4. Annoyingly enough, IPv6 has this defined under `100::` but alas.

I think `255.255.255.255` is the sanest default, but the real solution is
blocking a magic IP via router firewall.

* `127.0.0.1` — localhost

    This works out for basic cases, but this is a potential security vulnerability
    on machines that responds to requests — e.g. `doubleclick.net` => 127.0.0.1,
    unfiltered `mallory.doubleclick.net` can hijack localhost requests via
    [iframe domain](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy#Changing_origin)

* `0.0.0.0` — invalid destination

    Per spec and hardware, this is a bad packet and will be dropped. Unfortunately,
    a lot of software converts it into localhost and thus just as bad.

* `0.1.2.3` — invalid destination

    Unlike `0.0.0.0`, this does not have double meaning and thus _probably_ works
    more sanely.  Unfortunately, iOS waits for a timeout instead of dropping the
    request immediately.  I'm not sure why the behavior is different than on macOS.

* `255.255.255.255` — broadcast

    Any normal (unicast) requests to `255.255.255.255` are dropped since it's
    broadcast only. Unfortunately, there are weird edge cases, like using
    `ping doubleclick.net`.  These _probably_ won't manifest for ad blocking since
    web browsers _probably_ don't support broadcast packets, but you never know.

* `224.4.2.2` — multicast

    Like `255.255.255.255`, multicast addresses cannot handle unicast requests.
    And it's much harder to accidentally collide using multicast over broadcast.
    But iOS makes these requests "disappear" instead of showing an error message.
