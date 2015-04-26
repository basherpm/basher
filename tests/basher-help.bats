#!/usr/bin/env bats

load test_helper

@test "without args shows help for root command" {
  run basher-help

  assert_success
  assert_line "Usage: basher <command> [<args>]"
}

@test "invalid command" {
  run basher-help hello
  assert_failure "basher: no such command 'hello'"
}

@test "shows help for a specific command" {
  cat > "${BASHER_TMP_BIN}/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
# Summary: Says "hello" to you, from basher
# This command is useful for saying hello.
echo hello
SH

  run basher-help hello

  assert_success
  assert_output <<SH
Usage: basher hello <world>

This command is useful for saying hello.
SH
}
