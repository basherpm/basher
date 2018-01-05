include() {
  package="$1"
  file="$2"

  if [ -z "$package" ] || [ -z "$file" ]; then
    echo "Usage: include <package> <file>"
    return 1
  fi

  if [ ! -e "$BASHER_PREFIX/packages/$package" ]; then
    echo "Package not installed: $package"
    return 1
  fi

  if [ -e "$BASHER_PREFIX/packages/$package/$file" ]; then
    source "$BASHER_PREFIX/packages/$package/$file"
  else
    echo "File not found: $BASHER_PREFIX/packages/$package/$file"
    return 1
  fi
}
