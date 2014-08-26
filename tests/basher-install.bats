#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run basher-install
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "incorrect argument prints usage" {
  run basher-install first_arg
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "too many arguments prints usage" {
  run basher-install a/b wrong
  assert_failure
  assert_line "Usage: basher install <package>"
}

@test "executes install steps in right order" {
  mock_command basher-_clone
  mock_command basher-_validate
  mock_command basher-_deps
  mock_command basher-_link-bins

  run basher-install username/package
  assert_success "basher-_clone username/package
basher-_validate username/package
basher-_deps username/package
basher-_link-bins username/package"
}

@test "doesn't fail" {
  create_package username/package
  mock_clone

  run basher-install username/package
  assert_success
}
