#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-clone
  assert_failure
  assert_line "Usage: basher clone <user> <package>"
}

@test "missing arguments prints usage" {
  run basher-clone first_arg
  assert_failure
  assert_line "Usage: basher clone <user> <package>"
}

@test "clones a package from github" {
  mock_command git

  run basher-clone username package
  assert_success
  assert_output "git clone git://github.com/username/package.git ${BASHER_PACKAGES_PATH}/package"
}
