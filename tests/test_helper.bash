load lib/assertions

export BASHER_TEST_DIR="${BATS_TMPDIR}/basher"
export BASHER_ORIGIN_DIR="${BASHER_TEST_DIR}/origin"

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

mkdir -p "${BASHER_ORIGIN_DIR}"

teardown() {
  rm -rf "$BASHER_TEST_DIR"
}

load lib/mocks
load lib/package_helpers
