#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../hostcamo"

function test_as_filename {
  assert_equals 'google.com' \
    "$(as_filename http://google.com)"
  assert_equals 'google.com' \
    "$(as_filename https://google.com)"
  assert_equals 'google.com--banana' \
    "$(as_filename https://google.com/banana)"
}

function test_extract_domains {
  assert_equals 'google.com' \
    "$(extract_domains <<<'127.0.0.1 google.com')"
  assert_equals 'xn--oogle-wmc.com' \
    "$(extract_domains <<<'255.255.255.255         xn--oogle-wmc.com')"
  assert_equals 'microsoft.com' \
    "$(extract_domains <<<'   microsoft.com     ')"

  assert_equals '' \
    "$(extract_domains <<<'127.0.0.1 localhost')"
  assert_equals '' \
    "$(extract_domains <<<'ɢoogle.com')"
}

function test_reject {
  assert_equals '' \
    "$(reject 'localhost' <<<'localhost')"
  assert_equals 'localhost.localdomain' \
    "$(reject 'localhost' <<<'localhost.localdomain')"
  assert_equals '' \
    "$(reject 'localhost.localdomain' <<<'localhost.localdomain')"
  assert_equals '' \
    "$(reject '0.0.0.0' <<<'0.0.0.0')"

  assert_equals '0-0-0-0' \
    "$(reject '0.0.0.0' <<<'0-0-0-0')"
}
