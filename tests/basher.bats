#!/usr/bin/env bats

load test_helper

@test "default BASHER_ROOT" {
  BASHER_ROOT= run basher echo BASHER_ROOT
  assert_output "$HOME/.basher"
}

@test "inherited BASHER_ROOT" {
  BASHER_ROOT=/tmp/basher run basher echo BASHER_ROOT
  assert_output "/tmp/basher"
}
