create_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch package.sh
  git add .
  git commit -m "package.sh"
  cd ${BASHER_CWD}
}

create_link_package() {
  local name="$1"
  mkdir -p "${BASHER_PACKAGES_PATH}/link"
  ln -s whatever "${BASHER_PACKAGES_PATH}/link/$name"
}

create_invalid_package() {
  local package="$1"
  mkdir -p "${BASHER_ORIGIN_DIR}/$package"
  cd "${BASHER_ORIGIN_DIR}/$package"
  git init .
  touch dummy
  git add .
  git commit -m "dummy"
  cd ${BASHER_CWD}
}

create_exec() {
  local package="$1"
  local exec="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  mkdir -p bin
  touch bin/$exec

  if [ -e "package.sh" ]; then
    if grep -sq "BIN=" "package.sh"; then
      sed -e "/^BIN=/ s/$/:bin\/$exec/" package.sh > package.sh.tmp
      mv package.sh.tmp package.sh
    else
      echo "BIN=bin/$exec" >> package.sh
    fi
  fi

  git add .
  git commit -m "Add $exec"
  cd ${BASHER_CWD}
}

create_dep() {
  local package="$1"
  local dep="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"

  if [ -e "package.sh" ]; then
    if grep -sq "DEPS=" "package.sh"; then
      sed -e "/^DEPS=/ s;$;:$dep;" package.sh > package.sh.tmp
      mv package.sh.tmp package.sh
    else
      echo "DEPS=$dep" >> package.sh
    fi
  fi

  git add .
  git commit -m "Add dependency on $dep"
  cd ${BASHER_CWD}
}

create_testdep() {
  local package="$1"
  local dep="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"

  if [ -e "package.sh" ]; then
    if grep -sq "TESTDEPS=" "package.sh"; then
      sed -e "/^TESTDEPS=/ s;$;:$dep;" package.sh > package.sh.tmp
      mv package.sh.tmp package.sh
    else
      echo "TESTDEPS=$dep" >> package.sh
    fi
  fi

  git add .
  git commit -m "Add test dependency on $dep"
  cd ${BASHER_CWD}
}

create_runtime() {
  local package="$1"
  local runtime="$2"
  cd "${BASHER_ORIGIN_DIR}/$package"
  touch "$runtime"

  echo "RUNTIME=$runtime" >> package.sh

  git add .
  git commit -m "Add runtime $runtime"
  cd ${BASHER_CWD}
}
