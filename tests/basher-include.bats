#!/usr/bin/env bats

load test_helper

@test "without arguments, prints usage" {
  run basher-include

  assert_failure
  assert_line "Usage: basher include <package>"
}

@test "with a package without a runtime, displays an error" {
  export BASHER_SHELL=bash
  mock_clone
  create_package username/package
  basher-install username/package

  run basher-include username/package

  assert_failure
  assert_output "basher: package 'username/package' does not provide a runtime for 'bash'"
}

@test "with a package with a BASH_RUNTIME in BASH, outputs a line to source the file" {
  export BASHER_SHELL=bash
  mock_clone
  create_package username/package
  create_runtime username/package BASH runtime.sh
  basher-install username/package

  run basher-include username/package

  assert_success
  assert_output "source \"$BASHER_PACKAGES_PATH/username/package/runtime.sh\""
}

@test "with a package with a ZSH_RUNTIME in ZSH, outputs a line to source the file" {
  export BASHER_SHELL=zsh
  mock_clone
  create_package username/package
  create_runtime username/package ZSH runtime.sh
  basher-install username/package

  run basher-include username/package

  assert_success
  assert_output "source \"$BASHER_PACKAGES_PATH/username/package/runtime.sh\""
}

@test "with a package with a BASH_RUNTIME in FISH, displays an error" {
  export BASHER_SHELL=fish
  mock_clone
  create_package username/package
  create_runtime username/package BASH runtime.sh
  basher-install username/package

  run basher-include username/package

  assert_failure
  assert_output "basher: package 'username/package' does not provide a runtime for 'fish'"
}
