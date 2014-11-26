#!/usr/bin/env bats

load test_helper

@test "removes each man page from the cellar man" {
  create_package username/package
  create_man username/package exec.1
  create_man username/package exec.2
  mock_clone
  basher-install username/package

  run basher-_unlink-man username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/man/man1/exec.1)" ]
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/man/man2/exec.2)" ]
}
