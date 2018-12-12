create_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch README
  touch package.sh
  git add .
  git commit -m "Initial commit"
  cd "${BASHER_CWD}"
}

create_file() {
  local package="$1"
  local filename="$2"
  local content="$3"

  cd "${BASHER_ORIGIN_DIR}/$package"
  echo "$content" > "$filename"

  git add .
  git commit -m "Add $filename"
  cd "${BASHER_CWD}"
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

create_package_exec() {
  local package="$1"
  local exec="package_bin/$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p package_bin
  touch $exec

  touch "package.sh"

  if grep -sq "BINS=" "package.sh"; then
    sed -e "/^BINS=/ s;$;:$exec;" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "BINS=$exec" >> package.sh
  fi

  git add .
  git commit -m "Add package exec: $exec"
  cd ${BASHER_CWD}
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

set_remove_extension() {
  local package="$1"
  local remove_extension="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"

  touch "package.sh"

  if grep -sq "REMOVE_EXTENSION=" "package.sh"; then
    sed -e "s/^REMOVE_EXTENSION=$remove_extension//" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "REMOVE_EXTENSION=$remove_extension" >> package.sh
  fi

  git add .
  git commit -m "Set REMOVE_EXTENSION to $remove_extension."
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

  touch "package.sh"

  if grep -sq "BASH_COMPLETIONS=" "package.sh"; then
    sed -e "/^BASH_COMPLETIONS=/ s/$/:completions\/$comp/" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "BASH_COMPLETIONS=completions/$comp" >> package.sh
  fi

  git add .
  git commit -m "Add bash completions"
  cd ${BASHER_CWD}
}

create_zsh_compsys_completions() {
  local package="$1"
  local comp="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p completions
  echo "#compdef $2" > completions/$comp

  touch "package.sh"

  if grep -sq "ZSH_COMPLETIONS=" "package.sh"; then
    sed -e "/^ZSH_COMPLETIONS=/ s/$/:completions\/$comp/" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "ZSH_COMPLETIONS=completions/$comp" >> package.sh
  fi

  git add .
  git commit -m "Add bash completions"
  cd ${BASHER_CWD}
}

create_zsh_compctl_completions() {
  local package="$1"
  local comp="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p completions
  touch completions/$comp

  touch "package.sh"

  if grep -sq "ZSH_COMPLETIONS=" "package.sh"; then
    sed -e "/^ZSH_COMPLETIONS=/ s/$/:completions\/$comp/" package.sh > package.sh.tmp
    mv package.sh.tmp package.sh
  else
    echo "ZSH_COMPLETIONS=completions/$comp" >> package.sh
  fi

  git add .
  git commit -m "Add bash completions"
  cd ${BASHER_CWD}
}
