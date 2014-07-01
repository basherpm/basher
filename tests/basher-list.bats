#!/usr/bin/env bats

load test_helper

@test "with arguments shows usage" {
  run basher-list a_arg
  assert_failure
  assert_line "Usage: basher list"
}

@test "list installed packages" {
  mock_clone
  create_package username p1
  create_package username p2
  create_package username p3
  basher-install username p1
  basher-install username p2

  run basher-list
  assert_success
  assert_line "p1"
  assert_line "p2"
  refute_line "p3"
}
