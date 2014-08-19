create_command() {
  echo "$2" > "$BASHER_TMP_BIN/$1"
  chmod +x "$BASHER_TMP_BIN/$1"
}
