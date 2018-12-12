#!/usr/bin/env bats

load test_helper

@test "displays nothing if there are no packages" {
  run basher-outdated
  assert_success
  assert_output ""
}

@test "displays outdated packages" {
  mock_clone
  create_package username/outdated
  create_package username/uptodate
  basher-install username/outdated
  basher-install username/uptodate
  create_exec username/outdated "second"

  run basher-outdated
  assert_success
  assert_output username/outdated
}

@test "ignore packages checked out with a tag or ref" {
  mock_clone
  create_package username/tagged
  basher-install username/tagged

  create_command git 'if [ "$1" = "symbolic-ref" ]; then exit 128; fi'

  run basher-outdated
  assert_success
  assert_output ""
}
