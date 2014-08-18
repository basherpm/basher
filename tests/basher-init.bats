#!/usr/bin/env bats

load test_helper

@test "exports BASHER_ROOT" {
  BASHER_ROOT=/lol run basher-init -
  assert_success
  assert_line 0 'export BASHER_ROOT=/lol'
}

@test "adds cellar/bin to path" {
  run basher-init -
  assert_success
  assert_line 1 'export PATH="$BASHER_ROOT/cellar/bin:$PATH"'
}

@test "sources require runtime" {
  run basher-init -
  assert_success
  assert_line 2 'source "$BASHER_ROOT/runtime/require.bash"'
}

