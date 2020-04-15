#!/usr/bin/env bats

load test_helper

@test "without enough arguments, prints a useful message" {
  run basher-init -
  assert_failure
  assert_output "echo 'basher init usage has changed, please specify the name of your shell as an argument:

eval \"\$(basher init - bash)\" # or zsh, fish, sh etc

For more information, check this PR: https://github.com/basherpm/basher/pull/77
'"
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

@test "exports BASHER_PACKAGES_PATH" {
  BASHER_PACKAGES_PATH=/lol/packages run basher-init - bash
  assert_success
  assert_line -n 3 'export BASHER_PACKAGES_PATH=/lol/packages'
}

@test "adds cellar/bin to path" {
  run basher-init - bash
  assert_success
  assert_line -n 4 'export PATH="$BASHER_ROOT/cellar/bin:$PATH"'
}

@test "setup include function if it exists" {
  run basher-init - bash
  assert_line -n 5 '. "$BASHER_ROOT/lib/include.bash"'
}

@test "doesn't setup include function if it doesn't exist" {
  run basher-init - fakesh
  refute_line 'source "$BASHER_ROOT/lib/include.fakesh"'
}

@test "setup basher completions if available" {
  run basher-init - bash
  assert_success
  assert_line -n 6 '. "$BASHER_ROOT/completions/basher.bash"'
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
  assert_line -n 7 'for f in $(command ls "$BASHER_ROOT/cellar/completions/bash"); do source "$BASHER_ROOT/cellar/completions/bash/$f"; done'
}

@test "setup package completions (zsh)" {
  run basher-init - zsh
  assert_success
  assert_line -n 7 'fpath=("$BASHER_ROOT/cellar/completions/zsh/compsys" $fpath)'
  assert_line -n 8 'for f in $(command ls "$BASHER_ROOT/cellar/completions/zsh/compctl"); do source "$BASHER_ROOT/cellar/completions/zsh/compctl/$f"; done'
}

hasShell() {
  which "$1" >>/dev/null 2>&1
}

@test "is sh-compatible" {
  hasShell sh || skip "sh was not found in path."
  run sh -ec 'eval "$(basher init - sh)"'
  assert_success
}
