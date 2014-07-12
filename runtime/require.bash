#!/usr/bin/env bash

require() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: require <package>"
    return 1
  fi

  local package="$1"

  if [ -z "$package" ]; then
    echo "Usage: require <package>"
    return 1
  fi

  IFS=/ read -r __user __name <<< "$package"

  if [ -z "$__user" ]; then
    echo "Usage: require <package>"
    return 1
  fi

  if [ -z "$__name" ]; then
    echo "Usage: require <package>"
    return 1
  fi

  if [ -e "$BASHER_ROOT/cellar/packages/$package/package.sh" ]; then
    local line="$(cat ${BASHER_ROOT}/cellar/packages/$package/package.sh | grep RUNTIME=)"
    if [ "$line" = "" ]; then
      echo "Package '$package' doesn't export a runtime."
      return 1
    fi
    local runtime="${line#*=}"
    source "${BASHER_ROOT}/cellar/packages/$package/$runtime"
  else
    echo "Package '$package' doesn't export a runtime."
    return 1
  fi
}
