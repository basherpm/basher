#!/usr/bin/env bats

load test_helper

@test "updates basher" {
  mock_command git

  run basher-update
  assert_success
  assert_line "git pull"
}
