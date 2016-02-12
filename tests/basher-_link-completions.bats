#!/usr/bin/env bats

load test_helper

@test "links bash completions to cellar" {
  create_package username/package
  create_bash_completions username/package comp.bash
  mock_clone
  basher-_clone username/package

  run basher-_link-completions username/package

  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/completions/bash/comp.bash)" = "${BASHER_PACKAGES_PATH}/username/package/completions/comp.bash" ]
}

@test "links zsh completions to cellar" {
  create_package username/package
  create_zsh_completions username/package _exec
  mock_clone
  basher-_clone username/package

  run basher-_link-completions username/package

  assert_success
  assert [ "$(readlink $BASHER_ROOT/cellar/completions/zsh/_exec)" = "${BASHER_PACKAGES_PATH}/username/package/completions/_exec" ]
}

@test "does not fail if package doesn't have any completions" {
  create_package username/package
  mock_clone
  basher-_clone username/package

  run basher-_link-completions username/package

  assert_success
}
