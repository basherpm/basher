if [[ ! -o interactive ]]; then
    return
fi

compsys -K _basher basher

_basher() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(basher commands)"
  else
    completions="$(basher completions ${words[2,-2]})"
  fi

  reply=("${(ps:\n:)completions}")
}
