#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-_commands
  assert_failure
  assert_line "Usage: basher _commands <package>"
}

@test "lists commands" {
  run basher-_commands basher
  assert_success
  assert_line init
  assert_line help
  assert_line commands
}

@test "does not list hidden commands" {
  run basher-_commands basher
  assert_success
  refute_line _commands
}
