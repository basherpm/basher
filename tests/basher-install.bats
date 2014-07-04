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

@test "fails if there is no package.sh" {
  create_invalid_package username package
  mock_clone

  run basher-install username package
  assert_failure
  assert_line "package.sh not found"
}

@test "does not create package directory if there is no package.sh" {
  create_invalid_package username package
  mock_clone

  run basher-install username package
  assert_failure
  [ ! -d "$BASHER_PACKAGES_PATH/package" ]
}

@test "links each binary to the cellar bin" {
  create_package username package
  create_exec username package exec1
  create_exec username package exec2
  mock_clone

  run basher-install username package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "${BASHER_PACKAGES_PATH}/package/bin/exec2" ]
}
