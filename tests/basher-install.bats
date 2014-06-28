#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-install
  assert_failure
  assert_line "Usage: basher install <user> <package>"
}

@test "missing arguments prints usage" {
  run basher-install first_arg
  assert_failure
  assert_line "Usage: basher install <user> <package>"
}

@test "calls basher-clone" {
  mock_command basher-clone

  run basher-install username package
  assert_success
  assert_line "basher-clone username package"
}

@test "links each binary to the cellar bin" {
  create_package username package
  add_exec username package exec1
  add_exec username package exec2
  mock_clone

  run basher-install username package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "${BASHER_PACKAGES_PATH}/package/bin/exec2" ]
}
