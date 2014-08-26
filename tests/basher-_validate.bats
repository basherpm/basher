#!/usr/bin/env bats

load test_helper

@test "without arguments, prints usage" {
  run basher-_validate
  assert_failure
  assert_line "Usage: basher _validate <package>"
}

@test "with a package.sh, does nothing" {
  create_package username/package
  mock_clone
  basher-_clone username/package

  run basher-_validate username/package
  assert_success ""
}

@test "without a package.sh, gives an error" {
  create_invalid_package username/package
  mock_clone
  basher-_clone username/package

  run basher-_validate username/package
  assert_failure "ERROR: package.sh not found."
}
