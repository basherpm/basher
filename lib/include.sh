include() {
  local package="$1"
  local file="$2"

  if [ -z "$package" ] || [ -z "$file" ]; then
    echo "Usage: include <package> <file>" >&2
    return 1
  fi

  if [ ! -e "$BASHER_PREFIX/packages/$package" ]; then
    echo "Package not installed: $package" >&2
    return 1
  fi

  if [ -e "$BASHER_PREFIX/packages/$package/$file" ]; then
    . "$BASHER_PREFIX/packages/$package/$file" >&2
  else
    echo "File not found: $BASHER_PREFIX/packages/$package/$file" >&2
    return 1
  fi
}

include_once() {
  [[ "$BASHER_INCLUDED_ONCE" == *"$1/$2"* ]] && return 0
  include "$@" && BASHER_INCLUDED_ONCE="${BASHER_INCLUDED_ONCE}:$1/$2"
}
