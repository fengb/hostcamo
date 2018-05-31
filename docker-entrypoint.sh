#!/bin/bash

generate_conf() {
  echo no-hosts
  echo addn-hosts=/etc/dnsmasq.d/hostcamo.hosts

  if [ -n "$NAMESERVER" ]; then
    echo
    echo "no-resolv"
    <<<"$NAMESERVER" tr -s ":, " '\n' | sed "s/^/server=/g"
  fi
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  generate_conf >/etc/dnsmasq.d/hostcamo.conf
  exec "$@"
fi
