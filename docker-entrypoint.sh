#!/bin/bash

generate_conf() {
  echo no-hosts
  echo addn-hosts=/etc/dnsmasq.d/hostcamo.hosts

  if [ -n "${NAMESERVER-}" ]; then
    echo
    echo "no-resolv"
    <<<"$NAMESERVER" tr -s ":, " '\n' | sed "s/^/server=/g"
  fi
}

init_ovpn() {
  : "${OVPN_SERVER_NAME=hostcamo.example.com}"
  : "${OVPN_COMMON_NAME=$OVPN_SERVER_NAME}"

  if [ ! -e /etc/openvpn/pki ]; then
    ovpn_genconfig -u "udp://$OVPN_SERVER_NAME" -n "192.168.255.1" -d
    ovpn_initpki nopass <<<"$OVPN_COMMON_NAME"
    easyrsa build-client-full hostcamo nopass
  fi
  ovpn_run --daemon
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  init_ovpn
  generate_conf >/etc/dnsmasq.d/hostcamo.conf
  exec "$@"
fi
