include() {
  [[ "$BASHER_INCLUDED" == *" $1/$2 "* ]] && return 0
  local package="$1"
  local file_name="$2"

  if [ -z "$package" ] || [ -z "$file_name" ]; then
    echo "Usage: include <package> <file>" >&2
    return 1
  fi

  if [ ! -e "$BASHER_PREFIX/packages/$package" ]; then
    echo "Package not installed: $package" >&2
    return 1
  fi

  local file="$BASHER_PREFIX/packages/$package/$file_name"

  if [ -e "$file" ]; then
    . "$file" >&2 && BASHER_INCLUDED="${BASHER_INCLUDED} $package/$file_name "
  else
    echo "File not found: $file" >&2
    return 1
  fi
}
