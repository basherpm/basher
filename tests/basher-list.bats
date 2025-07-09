#!/usr/bin/env bats

load test_helper

@test "with arguments shows usage" {
  run basher-list a_arg
  assert_failure
  assert_line "Usage: basher list [-v]"
}

@test "list installed packages" {
  mock_clone
  create_package username/p1
  create_package username2/p2
  create_package username2/p3
  basher-install username/p1
  basher-install username2/p2

  run basher-list
  assert_success
  assert_line "username/p1"
  assert_line "username2/p2"
  refute_line "username2/p3"
}

@test "list installed packages with verbose flag shows remote URLs" {
  mock_clone
  create_package username/p1
  create_package username2/p2
  basher-install username/p1
  basher-install username2/p2
  
  run basher-list -v
  assert_success
  # Check that output contains package names in the verbose format
  # The format is: package-name (remote-url)
  assert_output --regexp "username/p1 +\(/tmp/basher/origin/username/p1\)"
  assert_output --regexp "username2/p2 +\(/tmp/basher/origin/username2/p2\)"
}

@test "verbose flag with arguments shows usage" {
  run basher-list -v extra_arg
  assert_failure
  assert_line "Usage: basher list [-v]"
}

@test "displays nothing if there are no packages" {
  run basher-list
  assert_success
  assert_output ""
}

@test "displays nothing if there are no packages with verbose flag" {
  run basher-list -v
  assert_success
  assert_output ""
}
