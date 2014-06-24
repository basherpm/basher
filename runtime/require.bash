#!/usr/bin/env bash

require() {
  local module_name="$1"
  source "$BASHER_ROOT/cellar/modules/$module_name/lib/$module_name.bash"
}
