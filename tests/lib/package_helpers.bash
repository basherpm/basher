create_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch package.sh
  git add .
  git commit -m "package.sh"
}

create_invalid_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch dummy
  git add .
  git commit -m "dummy"
}

create_exec() {
  local package="$1"
  local exec="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p bin
  touch bin/$exec
  chmod +x bin/$exec

  if [ -e "package.sh" ]; then
    if grep -sq "BIN=" "package.sh"; then
      sed -e "/^BIN=/ s/$/:bin\/$exec/" -i '' package.sh
    else
      echo "BIN=bin/$exec" >> package.sh
    fi
  fi

  git add .
  git commit -m "Add $exec"
}

create_runtime() {
  local package="$1"
  local runtime="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  touch "$runtime"

  echo "RUNTIME=$runtime" >> package.sh

  git add .
  git commit -m "Add runtime $runtime"
}
