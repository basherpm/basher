#!/usr/bin/env bats

load test_helper

@test "sources main basher lib" {
  run basher-init -
  assert_line "source $BASHER_ROOT/runtime/require.bash"
}

@test "exports BASHER_ROOT" {
  BASHER_ROOT=/lol run basher-init -
  assert_line 0 "export BASHER_ROOT=/lol"
}
