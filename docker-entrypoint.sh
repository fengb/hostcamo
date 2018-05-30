#!/bin/sh


cat >/etc/dnsmasq.d/hostcamo.conf <<EOM
no-hosts
addn-hosts=/etc/dnsmasq.d/hostcamo.hosts

$(if [ -n "$NAMESERVER" ]; then
  echo "no-resolv"
  echo $NAMESERVER | tr ":, " '\n' | sed "s/^/server=/g"
fi)
EOM

"$@"
