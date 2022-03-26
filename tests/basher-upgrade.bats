#!/usr/bin/env bats

load test_helper

@test "without arguments shows usage" {
  run basher-upgrade
  assert_failure
  assert_line "Usage: basher upgrade <package>"
}

@test "with invalid argument, shows usage" {
  run basher-upgrade lol
  assert_failure
  assert_line "Usage: basher upgrade <package>"
}

@test "with too many arguments, shows usage" {
  run basher-upgrade a/b wrong
  assert_failure
  assert_line "Usage: basher upgrade <package>"
}

@test "upgrades a package to the latest version" {
  mock_clone
  create_package username/package
  basher-install username/package
  create_exec username/package "second"

  basher-upgrade username/package

  run basher-outdated
  assert_output ""
}

@test "upgrade includes man page changes" {
  mock_clone
  create_package username/package
  basher-install username/package
  create_man username/package exec.1

  assert [ ! -d "$BASHER_INSTALL_MAN" ]
  basher-upgrade username/package


  run basher-outdated
  assert_output ""

  assert [ -d "$BASHER_INSTALL_MAN" ]
  assert [ -e "$BASHER_INSTALL_MAN/man1/exec.1" ]
}

@test "upgrade removes old binaries" {
  mock_clone
  create_package username/package
  basher-install username/package
  create_exec username/package "second"

  basher-upgrade username/package

  run basher-outdated
  assert_output ""

  assert [ -e "${BASHER_INSTALL_BIN}/second" ]

  remove_exec username/package "second"
  run basher-outdated
  assert_output "username/package"
  basher-upgrade username/package

  assert [ ! -e "${BASHER_INSTALL_BIN}/second" ]
}
