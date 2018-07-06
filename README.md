# hostcamo

This is [my hostfile](https://gitlab.com/fengb/hostcamo/-/jobs/artifacts/master/raw/dist/hosts?job=hosts). There are many like it, but this one is mine.

## Major features

* Uses `255.255.255.255` instead of more error prone `127.0.0.1` or `0.0.0.0` — [more details](docs/ip-address.md)
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
