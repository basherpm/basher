#!/usr/bin/env bats

load test_helper

@test "without arguments, shows usage" {
  run require
  assert_failure
  assert_line "Usage: require <package>"
}

@test "with an invalid argument, shows usage" {
  run require lol
  assert_failure
  assert_line "Usage: require <package>"
}

@test "with too many arguments, shows usage" {
  run require a/b wrong
  assert_failure
  assert_line "Usage: require <package>"
}

@test "when package is not installed, show error" {
  run require a/b
  assert_failure
  assert_line "Package 'a/b' is not installed."
}

@test "when package doesn't have a package.sh, show error" {
  mock_clone
  create_package username/package
  basher-install username/package
  run require username/package

  assert_failure
  assert_line "Package 'username/package' doesn't export a runtime."
}

@test "when package doesn't export a runtime, show error" {
  mock_clone
  create_package username/package
  create_exec username/package exec1
  basher-install username/package
  run require username/package

  assert_failure
  assert_line "Package 'username/package' doesn't export a runtime."
}

@test "when package exports a runtime, source it" {
  mock_clone
  create_package username/package
  create_runtime username/package some_runtime.sh
  basher-install username/package
  run require username/package

  echo $output
  assert_success
  assert_output ""
}
