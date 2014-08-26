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
  export PATH="${BATS_TEST_DIRNAME}/fixtures/commands/basher-_clone:$PATH"
}
