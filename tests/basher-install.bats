#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-install
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "incorrect argument prints usage" {
  run basher-install first_arg
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "too many arguments prints usage" {
  run basher-install a/b wrong
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "gives a warning if there is no package.sh" {
  create_invalid_package username package
  mock_clone

  run basher-install username/package
  assert_success
  assert_line "WARNING: package.sh not found, linking any binaries in bin directory"
}

@test "with a valid package, links each binary to the cellar bin" {
  create_package username package
  create_exec username package exec1
  create_exec username package exec2
  mock_clone

  run basher-install username/package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec2" ]
}

@test "with an invalid package, links each binary to the cellar bin" {
  create_invalid_package username package
  create_exec username package exec1
  create_exec username package exec2
  mock_clone

  run basher-install username/package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec2" ]
}
