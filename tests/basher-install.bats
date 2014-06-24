#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-install
  assert_failure
  assert_line "Usage: basher install <user> <module>"
}

@test "missing arguments prints usage" {
  run basher-install first_arg
  assert_failure
  assert_line "Usage: basher install <user> <module>"
}

@test "clones the module repo in the cellar" {
  mock_command git

  run basher-install username module
  assert_success
  assert_line "git clone git://github.com/username/module.git $BASHER_ROOT/cellar/modules/module"
}
