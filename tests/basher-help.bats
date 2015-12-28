#!/usr/bin/env bats

load test_helper

@test "without args shows summary of common commands" {
  run basher-help
  assert_success
  assert_line "Usage: basher <command> [<args>]"
  assert_line "Some useful basher commands are:"
}

@test "invalid command" {
  run basher-help hello
  assert_failure "basher: no such command 'hello'"
}

@test "shows help for a specific command" {
  cat > "${BASHER_TEST_DIR}/bin/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
# Summary: Says "hello" to you, from basher
# This command is useful for saying hello.
echo hello
SH

  run basher-help hello
  assert_success
  assert_output <<SH
Usage: basher hello <world>

This command is useful for saying hello.
SH
}

@test "replaces missing extended help with summary text" {
  cat > "${BASHER_TEST_DIR}/bin/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
# Summary: Says "hello" to you, from basher
echo hello
SH

  run basher-help hello
  assert_success
  assert_output <<SH
Usage: basher hello <world>

Says "hello" to you, from basher
SH
}

@test "extracts only usage" {
  cat > "${BASHER_TEST_DIR}/bin/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
# Summary: Says "hello" to you, from basher
# This extended help won't be shown.
echo hello
SH

  run basher-help --usage hello
  assert_success "Usage: basher hello <world>"
}

@test "multiline usage section" {
  cat > "${BASHER_TEST_DIR}/bin/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
#        basher hi [everybody]
#        basher hola --translate
# Summary: Says "hello" to you, from basher
# Help text.
echo hello
SH

  run basher-help hello
  assert_success
  assert_output <<SH
Usage: basher hello <world>
       basher hi [everybody]
       basher hola --translate

Help text.
SH
}

@test "multiline extended help section" {
  cat > "${BASHER_TEST_DIR}/bin/basher-hello" <<SH
#!shebang
# Usage: basher hello <world>
# Summary: Says "hello" to you, from basher
# This is extended help text.
# It can contain multiple lines.
#
# And paragraphs.

echo hello
SH

  run basher-help hello
  assert_success
  assert_output <<SH
Usage: basher hello <world>

This is extended help text.
It can contain multiple lines.

And paragraphs.
SH
}
