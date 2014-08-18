#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-new
  assert_failure
  assert_line "Usage: basher new <package-name>"
}

@test "fails if directory already exists" {
  mkdir package
  run basher-new package
  echo $output
  assert_failure
  assert_line "Directory 'package' already exists."
}

@test "creates a new directory for a package" {
  run basher-new package
  assert_success
  assert [ -d "$(pwd)/package" ]
}

@test "creates a package.sh file" {
  run basher-new package
  assert_success
  assert [ -e "$(pwd)/package/package.sh" ]
}
