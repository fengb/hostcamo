# hostcamo

This is [my hostfile](https://gitlab.com/fengb/hostcamo/-/jobs/artifacts/master/raw/dist/hosts?job=hosts). There are many like it, but this one is mine.

## Major features

* Tiny script — less code is easier to audit
* Leverages git history — easier to track changes
* [Pi-Hole adlist](https://raw.githubusercontent.com/pi-hole/pi-hole/master/adlists.default) — good enough for me

## How to use

Coming soon™

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
