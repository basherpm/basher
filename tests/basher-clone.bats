#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-clone
  assert_failure
  assert_line "Usage: basher clone <package>"
}

@test "invalid arguments prints usage" {
  run basher-clone first_arg
  assert_failure
  assert_line "Usage: basher clone <package>"
}

@test "too many arguments prints usage" {
  run basher-clone a/b second_arg
  assert_failure
  assert_line "Usage: basher clone <package>"
}

@test "fails if package is already present" {
  mkdir -p "$BASHER_PACKAGES_PATH/username/package"

  run basher-clone username/package
  echo $output
  assert_failure
  assert_output "Package 'username/package' is already present"
}

@test "clones a package from github" {
  mock_command git

  run basher-clone username/package
  assert_success
  assert_output "git clone git://github.com/username/package.git ${BASHER_PACKAGES_PATH}/username/package"
}
