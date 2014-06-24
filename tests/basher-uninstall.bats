#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-uninstall
  assert_failure
  assert_line "Usage: basher uninstall <module>"
}

@test "removes module directory" {
  mock_command rm

  run basher-uninstall module
  assert_success
  assert_line "rm -rf $BASHER_ROOT/cellar/modules/module"
}
