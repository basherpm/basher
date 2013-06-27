#!/usr/bin/env bats

load test_helper

@test "creates a new command with exec permission" {
  run basher-new-command basher-echo
  assert_success
  assert [ "$(cat ${BASHER_ROOT}/libexec/basher-echo)" = "#!/usr/bin/env bash" ]
  [[ "$(ls -l ${BASHER_ROOT}/libexec/basher-echo | cut -f 1 -d ' ')" == "-rwx"* ]]
}


@test "doesn't touch existing commands" {
  echo "echo" > "${BASHER_ROOT}/libexec/basher-echo"
  run basher-new-command basher-echo
  assert_failure
  assert [ "$(cat ${BASHER_ROOT}/libexec/basher-echo)" = "echo" ]
}

@test "creates a test for the command" {
  template="#!/usr/bin/env bats

load test_helper"
  run basher-new-command basher-echo
  assert_success
  assert [ "$(cat ${BASHER_ROOT}/tests/basher-echo.bats)" = "$template" ]
}
