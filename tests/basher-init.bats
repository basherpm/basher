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

@test "setup include function if it exists" {
  run basher-init - bash
  assert_line -n 4 '. "$BASHER_ROOT/lib/include.bash"'
}

@test "doesn't setup include function if it doesn't exist" {
  run basher-init - fakesh
  refute_line 'source "$BASHER_ROOT/lib/include.fakesh"'
}

@test "setup basher completions if available" {
  run basher-init - bash
  assert_success
  assert_line -n 5 '. "$BASHER_ROOT/completions/basher.bash"'
}

@test "does not setup basher completions if not available" {
  run basher-init - fakesh
  assert_success
  refute_line 'source "$BASHER_ROOT/completions/basher.fakesh"'
  refute_line 'source "$BASHER_ROOT/completions/basher.other"'
}

@test "setup package completions (bash)" {
  run basher-init - bash
  assert_success
  assert_line -n 6 'for f in $(command ls "$BASHER_ROOT/cellar/completions/bash"); do source "$BASHER_ROOT/cellar/completions/bash/$f"; done'
}

@test "setup package completions (zsh)" {
  run basher-init - zsh
  assert_success
  assert_line -n 6 'fpath=("$BASHER_ROOT/cellar/completions/zsh/compsys" $fpath)'
  assert_line -n 7 'for f in $(command ls "$BASHER_ROOT/cellar/completions/zsh/compctl"); do source "$BASHER_ROOT/cellar/completions/zsh/compctl/$f"; done'
}

hasShell() {
  which "$1" >>/dev/null 2>&1
}

@test "is sh-compatible" {
  hasShell sh || skip "sh was not found in path."
  run sh -ec 'eval "$(basher init - sh)"'
  assert_success
}

