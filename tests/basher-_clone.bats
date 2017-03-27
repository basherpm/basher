#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-_clone
  assert_failure
  assert_line "Usage: basher _clone <use_ssh> <site> <package> [<ref>]"
}

@test "invalid package prints usage" {
  run basher-_clone false github.com invalid_package
  assert_failure
  assert_line "Usage: basher _clone <use_ssh> <site> <package> [<ref>]"
}

@test "too many arguments prints usage" {
  run basher-_clone false site a/b ref fourth_arg
  assert_failure
  assert_line "Usage: basher _clone <use_ssh> <site> <package> [<ref>]"
}

@test "install a specific version" {
  mock_command git

  run basher-_clone false site username/package version
  assert_success
  assert_output "git clone --depth=1 -b version --recursive https://site/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "does nothing if package is already present" {
  mkdir -p "$BASHER_PACKAGES_PATH/username/package"

  run basher-_clone false github.com username/package

  assert_success
  assert_output "Package 'username/package' is already present"
}

@test "using a different site" {
  mock_command git

  run basher-_clone false site username/package
  assert_success
  assert_output "git clone --depth=1 --recursive https://site/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "without setting BASHER_FULL_CLONE, clones a package with depth option" {
  export BASHER_FULL_CLONE=
  mock_command git

  run basher-_clone false github.com username/package
  assert_success
  assert_output "git clone --depth=1 --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "setting BASHER_FULL_CLONE to true, clones a package without depth option" {
  export BASHER_FULL_CLONE=true
  mock_command git

  run basher-_clone false github.com username/package
  assert_success
  assert_output "git clone --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "setting BASHER_FULL_CLONE to false, clones a package with depth option" {
  export BASHER_FULL_CLONE=false
  mock_command git

  run basher-_clone false github.com username/package
  assert_success
  assert_output "git clone --depth=1 --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "using ssh protocol" {
  mock_command git

  run basher-_clone true site username/package
  assert_success
  assert_output "git clone --depth=1 --recursive git@site:username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}
