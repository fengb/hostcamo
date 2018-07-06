# hostcamo — IP address

This project explored a few different "black hole" IP addresses, but none of
them work perfectly in IPv4. Amusingly enough, IPv6 defines this behavior via
`100::` but alas.

`255.255.255.255` is probably the sanest default, but a more robust solution is
blocking a magic IP via router firewall.

* `127.0.0.1` — localhost

    This works for basic cases, but this is a potential security vulnerability on
    machines that responds to requests — e.g. when `doubleclick.net` => 127.0.0.1,
    an unfiltered `mallory.doubleclick.net` can hijack localhost requests via
    [iframe domain](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy#Changing_origin)

* `0.0.0.0` — invalid destination

    Per spec and hardware, this is supposed to be unroutable and should be dropped.
    Unfortunately, a lot of software (including browsers) converts it into localhost
    and thus just as bad.

* `0.1.2.3` — invalid destination

    Unlike `0.0.0.0`, this does not have double meaning in software and thus
    _probably_ works more sanely.  Unfortunately, iOS waits for a timeout instead of
    dropping the request immediately.  I'm not sure why the behavior is different
    than on macOS.

* `255.255.255.255` — broadcast

    Normal (unicast) requests to `255.255.255.255` are dropped since it's
    broadcast only. Unfortunately, there are weird edge cases, like using
    `ping doubleclick.net` will ping the entire subdomain.  These _probably_ won't
    manifest for ad blocking since web browsers _probably_ don't support broadcast
    packets, but you never know.

* `224.4.2.2` — multicast

    Like `255.255.255.255`, multicast addresses cannot handle unicast requests.
    And it's much harder to accidentally collide via multicast since the address
    space is 268 million times bigger. But iOS makes these requests "disappear"
    instead of showing an error message.
