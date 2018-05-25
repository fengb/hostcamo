# hostcamo

This is my hostfile. There are many like it, but this one is mine.

## How to use

```shell
$ curl -L https://gitlab.com/fengb/hostcamo/-/jobs/artifacts/master/raw/dist/hosts?job=hosts > hosts
```

More details coming soon™

## Major features

* Uses `255.255.255.255` — guaranteed invalid, unlike commonly used IPs (`0.0.0.0` and `127.0.0.1`)
* Tiny script — less code is easier to audit
* Leverages git history — easier to track changes
* Uses the same list as Pi-Hole — good enough for me
