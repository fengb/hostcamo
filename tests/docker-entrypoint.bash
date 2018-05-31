#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../docker-entrypoint.sh"

function assert_stdin {
	assert_equals "$(cat)" "$1"
}

function test_generate_conf {
	assert_stdin "$(generate_conf)" <<-EOF
		no-hosts
		addn-hosts=/etc/dnsmasq.d/hostcamo.hosts
	EOF

	assert_stdin "$(NAMESERVER='1.0.0.1' generate_conf)" <<-EOF
		no-hosts
		addn-hosts=/etc/dnsmasq.d/hostcamo.hosts

		no-resolv
		server=1.0.0.1
	EOF

exit
	assert_stdin "$(NAMESERVER='1.0.0.1 1.1.1.1' generate_conf)" <<-EOF
		no-hosts
		addn-hosts=/etc/dnsmasq.d/hostcamo.hosts

		no-resolv
		server=1.0.0.1
		server=1.1.1.1
	EOF
}
