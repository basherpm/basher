#!/usr/bin/env bats

load test_helper

@test "removes each binary from the cellar bin" {
  create_package username/package
  create_exec username/package exec1
  create_exec username/package exec2.sh
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/bin/exec1)" ]
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/bin/exec2)" ]
}

@test "removes root binaries from the cellar bin" {
  create_package username/package
  create_root_exec username/package exec3
  create_root_exec username/package exec4.sh
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/bin/exec3)" ]
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/bin/exec4)" ]
}

@test "doesn't remove root binaries if there is a bin folder" {
  create_package username/package
  create_root_exec username/package exec3
  mock_clone
  basher-install username/package
  mkdir "$BASHER_PACKAGES_PATH/username/package/bin"

  run basher-_unlink-bins username/package
  assert_success
  assert [ -e "$(readlink $BASHER_ROOT/cellar/bin/exec3)" ]
}
