load assertions

BASHER_TEST_DIR="${BATS_TMPDIR}/basher"

export BASHER_ROOT="${BASHER_TEST_DIR}/root"

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"

mkdir -p "${BASHER_ROOT}/libexec"
mkdir -p "${BASHER_ROOT}/tests"
mkdir -p "${BASHER_ROOT}/templates"

teardown() {
  rm -rf "$BASHER_TEST_DIR"
}
