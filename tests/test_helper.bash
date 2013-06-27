load assertions

BASHER_TEST_DIR="${BATS_TMPDIR}/basher"

export BASHER_ROOT="${BASHER_TEST_DIR}/root"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"
export PATH="${BASHER_TEST_DIR}/bin:$PATH"

mkdir -p "${BASHER_ROOT}/libexec"
mkdir -p "${BASHER_ROOT}/tests"
mkdir -p "${BASHER_ROOT}/templates"
mkdir -p "${BASHER_TEST_DIR}/bin"

teardown() {
  rm -rf "$BASHER_TEST_DIR"
}
