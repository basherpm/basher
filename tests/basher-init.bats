#!/usr/bin/env bats

load test_helper

@test "detects the shell" {
  SHELL=/bin/false run basher-init -
  assert_success
  assert_line -n 0 'export BASHER_SHELL=bash'
}

@test "exports BASHER_ROOT" {
  BASHER_ROOT=/lol run basher-init - bash
  assert_success
  assert_line -n 1 'export BASHER_ROOT=/lol'
}

@test "exports BASHER_PREFIX" {
  BASHER_PREFIX=/lol run basher-init - bash
  assert_success
  assert_line -n 2 'export BASHER_PREFIX=/lol'
}

@test "adds cellar/bin to path" {
  run basher-init - bash
  assert_success
  assert_line -n 3 'export PATH="$BASHER_ROOT/cellar/bin:$PATH"'
}

@test "setup basher completions if available" {
  mkdir -p "$BASHER_ROOT/completions"
  touch "$BASHER_ROOT/completions/basher.fakesh"
  run basher-init - fakesh
  assert_success
  assert_line -n 4 'source "$BASHER_ROOT/completions/basher.fakesh"'
}

@test "does not setup basher completions if not available" {
  mkdir -p "$BASHER_ROOT/completions"
  touch "$BASHER_ROOT/completions/basher.other"
  run basher-init - fakesh
  assert_success
  refute_line 'source "$BASHER_ROOT/completions/basher.fakesh"'
  refute_line 'source "$BASHER_ROOT/completions/basher.other"'
}

@test "setup package completions (bash)" {
  run basher-init - bash
  assert_success
  assert_line -n 4 'for f in $(command ls "$BASHER_ROOT/cellar/completions/bash"); do source "$BASHER_ROOT/cellar/completions/bash/$f"; done'
}

@test "setup package completions (zsh)" {
  run basher-init - zsh
  assert_success
  assert_line -n 4 'fpath=("$BASHER_ROOT/cellar/completions/zsh" $fpath)'
}
