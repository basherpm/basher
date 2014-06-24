load assertions

BASHER_TEST_DIR="${BATS_TMPDIR}/basher"

export BASHER_ROOT="${BASHER_TEST_DIR}/root"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
export PATH="${BASHER_TEST_DIR}/bin:$PATH"

mkdir -p "${BASHER_ROOT}/libexec"
mkdir -p "${BASHER_ROOT}/tests"
mkdir -p "${BASHER_ROOT}/cellar"
mkdir -p "${BASHER_ROOT}/cellar/bin"
mkdir -p "${BASHER_ROOT}/cellar/modules"

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
