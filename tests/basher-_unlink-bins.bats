#!/usr/bin/env bats

load test_helper

@test "removes each binary in BINS config from the install bin" {
  create_package username/package
  create_package_exec username/package exec1
  create_package_exec username/package exec2.sh
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec1)" ]
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec2.sh)" ]
}

@test "removes each binary from the install bin" {
  create_package username/package
  create_exec username/package exec1
  create_exec username/package exec2.sh
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec1)" ]
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec2.sh)" ]
}

@test "removes root binaries from the install bin" {
  create_package username/package
  create_root_exec username/package exec3
  create_root_exec username/package exec4.sh
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec3)" ]
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec4.sh)" ]
}

@test "doesn't remove root binaries if there is a bin folder" {
  create_package username/package
  create_root_exec username/package exec3
  mock_clone
  basher-install username/package
  mkdir "$BASHER_PACKAGES_PATH/username/package/bin"

  run basher-_unlink-bins username/package
  assert_success
  assert [ -e "$(readlink $BASHER_INSTALL_BIN/exec3)" ]
}

@test "doesn't remote root bins or files in bin folder if there is a BINS config on package.sh" {
  mock_clone

  create_package username/package
  create_package_exec username/package exec1
  create_exec username/package exec2
  create_root_exec username/package exec3
  basher-install username/package


  create_package username/package2
  create_root_exec username/package2 exec2
  basher-install username/package2

  create_package username/package3
  create_exec username/package3 exec3
  basher-install username/package3

  run basher-_unlink-bins username/package

  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec1)" ]
  assert [ -e "$(readlink $BASHER_INSTALL_BIN/exec2)" ]
  assert [ -e "$(readlink $BASHER_INSTALL_BIN/exec3)" ]
}

@test "does not fail if there are no binaries" {
  create_package username/package
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package

  assert_success
}

@test "removes binary when REMOVE_EXTENSION is true" {
  create_package username/package
  create_exec username/package exec1
  create_exec username/package exec2.sh
  set_remove_extension username/package true
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec1)" ]
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec2)" ]
}

@test "removes binary when REMOVE_EXTENSION is false" {
  create_package username/package
  create_exec username/package exec1
  create_exec username/package exec2.sh
  set_remove_extension username/package false
  mock_clone
  basher-install username/package

  run basher-_unlink-bins username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec1)" ]
  assert [ ! -e "$(readlink $BASHER_INSTALL_BIN/exec2.sh)" ]
}
