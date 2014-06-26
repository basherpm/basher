#!/usr/bin/env bash

require() {
  local package_name="$1"
  source "${BASHER_ROOT}/cellar/packages/$package_name/lib/$package_name.bash"
}
