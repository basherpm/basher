#!/usr/bin/env bats

load test_helper

@test "without arguments, prints usage" {
  run basher-_deps
  assert_failure
  assert_line "Usage: basher _deps <package>"
}

@test "without a package.sh, shows error" {
  mock_clone
  create_invalid_package "user/main"
  basher-_clone "user/main"

  run basher-_deps user/main
  assert_failure "ERROR: package.sh not found."
}

@test "without dependencies, does nothing" {
  mock_clone
  mock_command basher-install
  create_package "user/main"
  basher-_clone user/main

  run basher-_deps user/main
  assert_success ""
}

@test "installs runtime dependencies" {
  mock_clone
  mock_command basher-install
  create_package "user/main"
  create_dep "user/main" "user/dep1"
  create_dep "user/main" "user/dep2"
  basher-_clone user/main

  run basher-_deps user/main
  assert_success
  assert_line "basher-install user/dep1"
  assert_line "basher-install user/dep2"
}

@test "does not install test dependencies" {
  mock_clone
  mock_command basher-install
  create_package "user/main"
  create_dep "user/main" "user/dep"
  create_testdep "user/main" "user/testdep"
  basher-_clone user/main

  run basher-_deps user/main
  assert_success
  assert_line "basher-install user/dep"
  refute_line "basher-install user/testdep"
}
