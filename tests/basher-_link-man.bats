#!/usr/bin/env bats

load test_helper

@test "links each man page to install-man under correct subdirectory" {
  create_package username/package
  create_man username/package exec.1
  create_man username/package exec.2
  mock_clone
  basher-_clone false site username/package

  run basher-_link-man username/package
echo "$output"
  assert_success
  assert [ "$(readlink $BASHER_INSTALL_MAN/man1/exec.1)" = "${BASHER_PACKAGES_PATH}/username/package/man/exec.1" ]
  assert [ "$(readlink $BASHER_INSTALL_MAN/man2/exec.2)" = "${BASHER_PACKAGES_PATH}/username/package/man/exec.2" ]
}
