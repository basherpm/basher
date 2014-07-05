#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-uninstall
  assert_failure
  assert_line "Usage: basher uninstall <package>"
}

@test "removes package directory" {
  mock_clone
  create_package username package
  basher-install username package

  run basher-uninstall package
  assert_success
  [ ! -d "$BASHER_PACKAGES_PATH/package" ]
}

@test "with package.sh, removes binaries" {
  mock_clone
  create_package username package
  create_exec username package exec1
  basher-install username package

  run basher-uninstall package
  assert_success
  [ ! -e "$BASHER_ROOT/cellar/bin/exec1" ]
}

@test "without package.sh, removes binaries" {
  mock_clone
  create_invalid_package username package
  create_exec username package exec1
  basher-install username package

  run basher-uninstall package
  assert_success
  assert_line "WARNING: package.sh not found, unlinking any binaries in bin directory"
  [ ! -e "$BASHER_ROOT/cellar/bin/exec1" ]
}

@test "does not remove other package directories and binaries" {
  mock_clone
  create_package username package1
  create_exec username package1 exec1
  create_package username package2
  create_exec username package2 exec2
  basher-install username package1
  basher-install username package2

  run basher-uninstall package1
  assert_success
  [ -d "$BASHER_PACKAGES_PATH/package2" ]
  [ -e "$BASHER_ROOT/cellar/bin/exec2" ]
}
