#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-link
  assert_failure
  assert_line "Usage: basher link <directory>"
}

@test "fails with an invalid path" {
  run basher-link invalid
  assert_failure
  assert_output "Directory 'invalid' not found."
}

@test "links the package to cellar under link user" {
  mkdir package1
  run basher-link package1
  assert_success
  assert [ "$(readlink $BASHER_PACKAGES_PATH/link/package1)" = "$(pwd)/package1" ]
}

@test "calls link-bins" {
  mock_command basher-link-bins
  mkdir package2
  run basher-link package2
  assert_success
  assert_output "basher-link-bins link/package2"
}
