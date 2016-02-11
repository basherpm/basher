#!/usr/bin/env bats

load test_helper

@test "links each file inside bin folder to cellar bin" {
  create_package username/package
  create_exec username/package exec1
  create_exec username/package exec2.sh
  mock_clone
  basher-_clone username/package

  run basher-_link-bins username/package
  echo "$output"
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec1" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec2)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec2.sh" ]
}

@test "links each exec file in package root to cellar bin" {
  create_package username/package
  create_root_exec username/package exec3
  create_root_exec username/package exec4.sh
  mock_clone
  basher-_clone username/package

  run basher-_link-bins username/package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec3)" = "${BASHER_PACKAGES_PATH}/username/package/exec3" ]
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec4)" = "${BASHER_PACKAGES_PATH}/username/package/exec4.sh" ]
}

@test "doesn't link root bins if there is a bin folder" {
  create_package username/package
  create_exec username/package exec1
  create_root_exec username/package exec2
  mock_clone
  basher-_clone username/package

  run basher-_link-bins username/package
  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/bin/exec1)" = "${BASHER_PACKAGES_PATH}/username/package/bin/exec1" ]
  assert [ ! -e "$(readlink $BASHER_ROOT/cellar/bin/exec2)" ]
}
