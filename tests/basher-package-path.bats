#!/usr/bin/env bats

load test_helper

@test "without arguments, prints usage" {
  run basher-package-path
  assert_failure
  assert_line "Usage: source \"\$(basher package-path <package>)/file.sh\""
}

@test "outputs the package path" {
  mock_clone
  create_package username/package
  basher-install username/package

  run basher-package-path username/package
  assert_success "$BASHER_PACKAGES_PATH/username/package"
}
