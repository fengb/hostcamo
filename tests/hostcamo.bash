source "$(dirname "$BASH_SOURCE")/../hostcamo"

function test_as_filename {
  assert_equals 'google.com' \
    "$(as_filename http://google.com)"
  assert_equals 'google.com' \
    "$(as_filename https://google.com)"
  assert_equals 'google.com--banana' \
    "$(as_filename https://google.com/banana)"
}

function test_strip {
  assert_equals 'localhost' \
    "$(strip <<<'127.0.0.1 localhost')"
  assert_equals 'broadcast' \
    "$(strip <<<'255.255.255.255 broadcast')"
}

function test_filter_valid_domains {
  assert_equals '' \
    "$(filter <<<$'\n\n\n')"
  assert_equals 'realdomain.com' \
    "$(filter <<<'realdomain.com')"
  assert_equals 'xn--oogle-wmc.com' \
    "$(filter <<<'xn--oogle-wmc.com')"
  assert_equals '' \
    "$(filter <<<'ɢoogle.com')"
}

function test_filter_whitelist {
  assert_equals '' \
    "$(filter <<<'localhost')"
  assert_equals '' \
    "$(filter <<<'localhost.localdomain')"
  assert_equals '' \
    "$(filter <<<'0.0.0.0')"
  assert_equals '0-0-0-0' \
    "$(filter <<<'0-0-0-0')"
}
