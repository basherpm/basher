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
