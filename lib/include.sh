include() {
  package="$1"
  file="$2"

  if [ -e "$BASHER_PREFIX/packages/$package/$file" ]; then
    source "$BASHER_PREFIX/packages/$package/$file"
  else
    echo "File not found: $BASHER_PREFIX/packages/$package/$file"
  fi
}
