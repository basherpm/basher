#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-install
  assert_failure
  assert_line "Usage: basher install <user> <package>"
}

@test "missing arguments prints usage" {
  run basher-install first_arg
  assert_failure
  assert_line "Usage: basher install <user> <package>"
}

@test "clones the package repo in the cellar" {
  mock_command git

  run basher-install username package
  assert_success
  assert_line "git clone git://github.com/username/package.git $BASHER_ROOT/cellar/packages/package"
}

@test "links each binary to the cellar bin" {
  install_package username package
  mock_command git

  run basher-install username package
echo $output
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "$BASHER_ROOT/cellar/packages/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "$BASHER_ROOT/cellar/packages/package/bin/exec2" ]
}
