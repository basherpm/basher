#!/usr/bin/env bats

load test_helper

@test "unlinks bash completions from prefix/completions" {
  create_package username/package
  create_bash_completions username/package comp.bash
  mock_clone
  basher-install username/package

  run basher-_unlink-completions username/package
  assert_success
  assert [ ! -e "$($BASHER_PREFIX/completions/bash/comp.bash)" ]
}

@test "unlinks zsh compsys completions from prefix/completions" {
  create_package username/package
  create_zsh_compsys_completions username/package _exec
  mock_clone
  basher-install username/package

  run basher-_unlink-completions username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_PREFIX/completions/zsh/compsys/_exec)" ]
}

@test "unlinks zsh compctl completions from prefix/completions" {
  create_package username/package
  create_zsh_compctl_completions username/package exec
  mock_clone
  basher-install username/package

  run basher-_unlink-completions username/package
  assert_success
  assert [ ! -e "$(readlink $BASHER_PREFIX/completions/zsh/compctl/exec)" ]
}
