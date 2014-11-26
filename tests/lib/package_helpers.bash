create_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch README
  git add .
  git commit -m "Initial commit"
  cd "${BASHER_CWD}"
}

create_link_package() {
  local name="$1"
  mkdir -p "${BASHER_PACKAGES_PATH}/link"
  ln -s whatever "${BASHER_PACKAGES_PATH}/link/$name"
}

create_man() {
  local package="$1"
  local man="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p man
  touch "man/$man"

  git add .
  git commit -m "Add $man"
  cd "${BASHER_CWD}"
}

create_exec() {
  local package="$1"
  local exec="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p bin
  touch bin/$exec

  git add .
  git commit -m "Add $exec"
  cd ${BASHER_CWD}
}

create_root_exec() {
  local package="$1"
  local exec="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  touch $exec
  chmod +x "$exec"

  git add .
  git commit -m "Add root exec: $exec"
  cd ${BASHER_CWD}
}
