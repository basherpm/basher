load assertions

BASHER_TEST_DIR="${BATS_TMPDIR}/basher"

export BASHER_ROOT="${BASHER_TEST_DIR}/root"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
export PATH="${BASHER_TEST_DIR}/bin:$PATH"

mkdir -p "${BASHER_ROOT}/libexec"
mkdir -p "${BASHER_ROOT}/tests"
mkdir -p "${BASHER_ROOT}/modules"
mkdir -p "${BASHER_TEST_DIR}/bin"

teardown() {
  rm -rf "$BASHER_TEST_DIR"
}

mock_git() {
  export PATH="${BATS_TEST_DIRNAME}/path/git:$PATH"
}

mock_rm() {
  export PATH="${BATS_TEST_DIRNAME}/path/rm:$PATH"
}
