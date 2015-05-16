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

create_dep() {
  local package="$1"
  local dep="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"

  touch "package.sh"

  if grep -sq "DEPS=" "package.sh"; then
    sed -e "/^DEPS=/ s;$;:$dep;" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "DEPS=$dep" >> package.sh
  fi

  git add .
  git commit -m "Add dependency on $dep"
  cd ${BASHER_CWD}
}

create_bash_completions() {
  local package="$1"
  local comp="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p completions
  touch completions/$comp

  if [ -e "package.sh" ]; then
    if grep -sq "BASH_COMPLETIONS=" "package.sh"; then
      sed -e "/^BASH_COMPLETIONS=/ s/$/:completions\/$comp/" package.sh > package.sh.tmp
      mv package.sh.tmp package.sh
    fi
  else
    echo "BASH_COMPLETIONS=completions/$comp" >> package.sh
  fi

  git add .
  git commit -m "Add bash completions"
  cd ${BASHER_CWD}
}

create_zsh_completions() {
  local package="$1"
  local comp="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p completions
  touch completions/$comp

  if [ -e "package.sh" ]; then
    if grep -sq "ZSH_COMPLETIONS=" "package.sh"; then
      sed -e "/^ZSH_COMPLETIONS=/ s/$/:completions\/$comp/" package.sh > package.sh.tmp
      mv package.sh.tmp package.sh
    fi
  else
    echo "ZSH_COMPLETIONS=completions/$comp" >> package.sh
  fi

  git add .
  git commit -m "Add bash completions"
  cd ${BASHER_CWD}
}
