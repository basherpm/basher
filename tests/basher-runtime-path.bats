#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-runtime-path
  assert_failure
  assert_line "Usage: source \"\$(basher runtime-path <package>)\""
}

@test "fails for packages without a runtime" {
  mock_clone
  create_package username/package
  basher-install username/package

  run basher-runtime-path username/package
  assert_failure "ERROR: package 'username/package' does not export a runtime."
}

@test "outputs the package runtime" {
  mock_clone
  create_package username/package
  create_runtime username/package runtime.sh
  basher-install username/package

  run basher-runtime-path username/package
  assert_success "$BASHER_PACKAGES_PATH/username/package/runtime.sh"
}
