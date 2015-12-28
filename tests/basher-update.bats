#!/usr/bin/env bats

load test_helper

@test "with arguments shows usage" {
  run basher-update package_name
  assert_failure
  assert_line "Usage: basher update"
}

@test "updates basher" {
  mock_command git

  run basher-update
  assert_success
  assert_line "git pull"
}
