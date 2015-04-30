#!/usr/bin/env bats

load test_helper

@test "with arguments shows usage" {
  run basher-update package_name
  assert_failure
  assert_line "Usage: basher update"
}

@test "updates basher" {
  mock_command git
  mock_command basher-_check-deps

  run basher-update

  assert_success
  assert_line "basher-_check-deps "
  assert_line "git pull"
}
