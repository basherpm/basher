#!/usr/bin/env bats

load test_helper

@test "lists commands" {
  run basher-commands
  assert_success
  assert_line init
  assert_line help
  assert_line commands
}
