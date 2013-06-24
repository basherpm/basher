load assertions

export PATH="${BATS_TEST_DIRNAME}/libexec:$PATH"
export PATH="${BATS_TEST_DIRNAME}/../libexec:$PATH"

setup() {
  export BASHER_ROOT="$BATS_TEST_DIRNAME/.."
  eval "$(basher init -)"
}
