load assertions

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

mock_clone() {
  export PATH="${BATS_TEST_DIRNAME}/fixtures/commands/basher-clone:$PATH"
}

create_package() {
  local username="$1"
  local package="$2"
  mkdir -p "${BASHER_ORIGIN_DIR}/$username/$package"
  cd "${BASHER_ORIGIN_DIR}/$username/$package"
  git init .
  touch dummy
  git add .
  git commit -m "first"
}

add_exec() {
  local username="$1"
  local package="$2"
  local exec="$3"
  cd "${BASHER_ORIGIN_DIR}/$username/$package"
  mkdir -p bin
  touch bin/$exec
  chmod +x bin/$exec
  git add .
  git commit -m "Add $exec"
}
