#!/usr/bin/env bats

load test_helper

@test "without arguments, prints an error" {
  eval "$(basher-init - sh)"
  run include
  assert_failure
  assert_output "Usage: include <package> <file>"
}

@test "with one argument, prints an error" {
  eval "$(basher-init - sh)"
  run include user/repo
  assert_failure
  assert_output "Usage: include <package> <file>"
}

@test "when package is not installed, prints an error" {
  eval "$(basher-init - sh)"
  run include user/repo file
  assert_failure
  assert_output "Package not installed: user/repo"
}

@test "when file doesn't exist, prints an error" {
  create_package username/repo
  mock_clone
  basher-_clone false site username/repo

  eval "$(basher-init - sh)"
  run include username/repo non_existent
  assert_failure
  assert_output "File not found: $BASHER_PREFIX/packages/username/repo/non_existent"
}

@test "sources a file into the current shell" {
  create_package username/repo
  create_file username/repo function.sh "func_name() { echo DONE; }"
  mock_clone
  basher-_clone false site username/repo

  eval "$(basher-init - sh)"
  include username/repo function.sh

  run func_name
  assert_success
  assert_output "DONE"
}
