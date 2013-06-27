#!/usr/bin/env bats

load test_helper

@test "creates a new command with exec permission on current directory" {
  cd "$BASHER_ROOT"

  run basher-new-command basher-echo
  assert_success
  assert [ "$(cat libexec/basher-echo)" = "#!/usr/bin/env bash" ]
  [[ "$(ls -l libexec/basher-echo | cut -f 1 -d ' ')" == "-rwx"* ]]
}

@test "doesn't touch existing commands" {
  cd "$BASHER_ROOT"
  echo "echo" > "libexec/basher-echo"

  run basher-new-command basher-echo
  assert_failure
  assert [ "$(cat libexec/basher-echo)" = "echo" ]
}

@test "creates a test for the command" {
  cd "$BASHER_ROOT"
  template="#!/usr/bin/env bats

load test_helper"

  run basher-new-command basher-echo
  assert_success
  assert [ "$(cat tests/basher-echo.bats)" = "$template" ]
}
