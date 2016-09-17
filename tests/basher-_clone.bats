#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-_clone
  assert_failure
  assert_line "Usage: basher _clone <package>"
}

@test "invalid arguments prints usage" {
  run basher-_clone first_arg
  assert_failure
  assert_line "Usage: basher _clone <package>"
}

@test "too many arguments prints usage" {
  run basher-_clone a/b second_arg
  assert_failure
  assert_line "Usage: basher _clone <package>"
}

@test "does nothing if package is already present" {
  mkdir -p "$BASHER_PACKAGES_PATH/username/package"

  run basher-_clone username/package

  assert_success
  assert_output "Package 'username/package' is already present"
}

@test "without setting BASHER_FULL_CLONE, clones a package from github with depth option" {
  export BASHER_FULL_CLONE=
  mock_command git

  run basher-_clone username/package
  assert_success
  assert_output "git clone --depth=1 --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "setting BASHER_FULL_CLONE to true, clones a package from github without depth option" {
  export BASHER_FULL_CLONE=true
  mock_command git

  run basher-_clone username/package
  assert_success
  assert_output "git clone --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}

@test "setting BASHER_FULL_CLONE to false, clones a package from github with depth option" {
  export BASHER_FULL_CLONE=false
  mock_command git

  run basher-_clone username/package
  assert_success
  assert_output "git clone --depth=1 --recursive https://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}
