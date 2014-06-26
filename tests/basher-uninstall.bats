#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-uninstall
  assert_failure
  assert_line "Usage: basher uninstall <package>"
}

@test "removes package directory" {
  mock_command rm

  run basher-uninstall package
  assert_success
  assert_line "rm -rf $BASHER_ROOT/cellar/packages/package"
}
