load assertions

BASHER_TEST_DIR="${BATS_TMPDIR}/basher"

export BASHER_ROOT="${BASHER_TEST_DIR}/root"
export BASHER_PACKAGES_PATH="$BASHER_ROOT/cellar/packages"

export FIXTURES_DIR="${BATS_TEST_DIRNAME}/fixtures"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
export PATH="${BASHER_TEST_DIR}/bin:$PATH"

mkdir -p "${BASHER_ROOT}/libexec"
mkdir -p "${BASHER_ROOT}/tests"
mkdir -p "${BASHER_ROOT}/cellar"
mkdir -p "${BASHER_ROOT}/cellar/bin"
mkdir -p "${BASHER_ROOT}/cellar/packages"

mkdir -p "${BASHER_TEST_DIR}/bin"
mkdir -p "${BASHER_TEST_DIR}/path"

teardown() {
  rm -rf "$BASHER_TEST_DIR"
}

mock_command() {
  local command="$1"
  mkdir -p "${BASHER_TEST_DIR}/path/$command"
  cat > "${BASHER_TEST_DIR}/path/$command/$command" <<SH
#!/usr/bin/env bash

echo "$command \$@"
SH
  chmod +x "${BASHER_TEST_DIR}/path/$command/$command"
  export PATH="${BASHER_TEST_DIR}/path/$command:$PATH"
}

install_package() {
  local username="$1"
  local package="$2"
  cp -r "${FIXTURES_DIR}/repos/$username/$package" "${BASHER_ROOT}/cellar/packages"
}
