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

@test "default BASHER_PREFIX" {
  BASHER_ROOT= BASHER_PREFIX= run basher echo BASHER_PREFIX
  assert_output "$HOME/.basher/cellar"
}

@test "inherited BASHER_PREFIX" {
  BASHER_PREFIX=/usr/local run basher echo BASHER_PREFIX
  assert_output "/usr/local"
}

@test "BASHER_PREFIX based on BASHER_ROOT" {
  BASHER_ROOT=/tmp/basher BASHER_PREFIX= run basher echo BASHER_PREFIX
  assert_output "/tmp/basher/cellar"
}

@test "inherited BASHER_PACKAGES_PATH" {
  BASHER_PACKAGES_PATH=/usr/local/packages run basher echo BASHER_PACKAGES_PATH
  assert_output "/usr/local/packages"
}

@test "BASHER_PACKAGES_PATH based on BASHER_PREFIX" {
  BASHER_PREFIX=/tmp/basher BASHER_PACKAGES_PATH= run basher echo BASHER_PACKAGES_PATH
  assert_output "/tmp/basher/packages"
}

@test "default BASHER_INSTALL_BIN" {
  BASHER_ROOT= BASHER_PREFIX= BASHER_INSTALL_BIN= run basher echo BASHER_INSTALL_BIN
  assert_output "$HOME/.basher/cellar/bin"
}

@test "inherited BASHER_INSTALL_BIN" {
  BASHER_INSTALL_BIN=/opt/bin run basher echo BASHER_INSTALL_BIN
  assert_output "/opt/bin"
}

@test "BASHER_INSTALL_BIN based on BASHER_PREFIX" {
  BASHER_INSTALL_BIN= BASHER_ROOT=/tmp/basher BASHER_PREFIX=/usr/local run basher echo BASHER_INSTALL_BIN
  assert_output "/usr/local/bin"
}

@test "default BASHER_INSTALL_MAN" {
  BASHER_ROOT= BASHER_PREFIX= BASHER_INSTALL_MAN= run basher echo BASHER_INSTALL_MAN
  assert_output "$HOME/.basher/cellar/man"
}

@test "inherited BASHER_INSTALL_MAN" {
  BASHER_INSTALL_MAN=/opt/man run basher echo BASHER_INSTALL_MAN
  assert_output "/opt/man"
}

@test "BASHER_INSTALL_MAN based on BASHER_PREFIX" {
  BASHER_INSTALL_MAN= BASHER_PREFIX=/usr/local run basher echo BASHER_INSTALL_MAN
  assert_output "/usr/local/man"
}
