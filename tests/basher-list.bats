#!/usr/bin/env bats

load test_helper

@test "with arguments shows usage" {
  run basher-list a_arg
  assert_failure
  assert_line "Usage: basher list [-v]"
}

@test "list installed packages" {
  mock_clone
  create_package username/p1
  create_package username2/p2
  create_package username2/p3
  basher-install username/p1
  basher-install username2/p2

  run basher-list
  assert_success
  assert_line "username/p1"
  assert_line "username2/p2"
  refute_line "username2/p3"
}

@test "verbose flag with arguments shows usage" {
  run basher-list -v extra_arg
  assert_failure
  assert_line "Usage: basher list [-v]"
}

@test "displays nothing if there are no packages" {
  run basher-list
  assert_success
  assert_output ""
}

@test "displays nothing if there are no packages with verbose flag" {
  run basher-list -v
  assert_success
  assert_output ""
}

@test "verbose flag shows complete output format for single package" {
  mock_clone
  create_package username/package
  create_exec username/package tool1
  create_exec username/package tool2.sh
  basher-install username/package
  
  run basher-list -v
  assert_success
  
  # Check exact output format
  assert_line --index 0 --regexp "username/package +\(${BASHER_ORIGIN_DIR}/username/package\)"
  assert_line --index 1 "  Executables:"
  assert_line --index 2 "    - tool1"
  assert_line --index 3 "    - tool2.sh"
  assert_line --index 4 ""  # blank line
}

@test "verbose flag with multiple packages shows each with executables" {
  mock_clone
  
  # First package with executables
  create_package user1/pkg1
  create_exec user1/pkg1 cmd1
  basher-install user1/pkg1
  
  # Second package with different executables
  create_package user2/pkg2
  create_exec user2/pkg2 cmd2
  create_exec user2/pkg2 cmd3
  basher-install user2/pkg2
  
  # Third package without executables
  create_package user3/pkg3
  echo "readme" > "$BASHER_ORIGIN_DIR/user3/pkg3/README"
  basher-install user3/pkg3
  
  run basher-list -v
  assert_success
  
  # Verify all packages are listed
  assert_output --partial "user1/pkg1"
  assert_output --partial "user2/pkg2"
  assert_output --partial "user3/pkg3"
  
  # Verify executables are shown
  assert_output --partial "    - cmd1"
  assert_output --partial "    - cmd2"
  assert_output --partial "    - cmd3"
  
  # Verify each package with executables has the header
  local exec_headers=$(echo "$output" | grep -c "  Executables:")
  assert_equal "$exec_headers" "2"  # Only 2 packages have executables
}
