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

@test "links the package to packages under link user" {
  mock_command basher-_link-bins
  mock_command basher-_link-completions
  mkdir package1
  run basher-link package1
  assert_success
  assert [ "$(readlink $BASHER_PACKAGES_PATH/link/package1)" = "$(pwd)/package1" ]
}

@test "calls link-bins" {
  mock_command basher-_link-bins
  mock_command basher-_link-completions
  mkdir package2
  run basher-link package2
  assert_success
  assert_line "basher-_link-bins link/package2"
}

@test "calls link-completions" {
  mock_command basher-_link-bins
  mock_command basher-_link-completions
  mkdir package2
  run basher-link package2
  assert_success
  assert_line "basher-_link-completions link/package2"
}
