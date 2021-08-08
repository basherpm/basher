#!/usr/bin/env bash

die() {
  echo "!! $1 " >&2
  echo "!! -----------------------------" >&2
  exit 1
}

xdg_basher_dir="${XDG_DATA_HOME:-$HOME/.local/share}/basher"

## stop if basher is already installed
[[ -d "$HOME/.basher" ]] && die "basher is already installed on [$HOME/.basher]"
[[ -d "$xdg_basher_dir" ]] && die "basher is already installed on [$xdg_basher_dir]"

## stop if git is not installed
git version >/dev/null 2>&1 || die "git is not installed on this machine"

## install the scripts on ~/.basher
echo ". download basher code to ~/.basher"
git clone https://github.com/basherpm/basher.git ~/.basher 2> /dev/null

## now check what shell is running
shell_type=$(basename "$SHELL")
echo ". detected shell type: $shell_type"
case "$shell_type" in
bash)  startup_type="simple" ; startup_script="$HOME/.bashrc" ;;
zsh)   startup_type="simple" ; startup_script="$HOME/.zshrc"  ;;
sh)    startup_type="simple" ; startup_script="$HOME/.profile";;
fish)  startup_type="fish"   ; startup_script="$HOME/.config/fish/config.fish"  ;;
*)     startup_type="?"      ; startup_script="" ;   ;;
esac

## startup script should exist already
[[ -n "$startup_script" && ! -f "$startup_script" ]] && die "startup script [$startup_script] does not exist"

## basher_keyword will allow us to remove the lines upon uninstall
basher_keyword="basher5ea843"

## now add the basher initialisation lines to the user's startup script
echo ". add basher initialisation to [$startup_script]"
if [[ "$startup_type" == "simple" ]]; then
  (
    echo "export PATH=\"\$HOME/.basher/bin:\$PATH\"   ##$basher_keyword"
    # shellcheck disable=SC2086
    echo "eval \"\$(basher init - $shell_type)\"             ##$basher_keyword"
  ) >>"$startup_script"
elif [[ "$startup_type" == "fish" ]]; then
  (
    echo "if test -d ~/.basher          ##$basher_keyword"
    echo "  set basher ~/.basher/bin    ##$basher_keyword"
    echo "end                           ##$basher_keyword"
    # shellcheck disable=SC2154
    echo "set -gx PATH \$basher \$PATH    ##$basher_keyword"
    echo "status --is-interactive; and . (basher init - $shell_type | psub)    ##$basher_keyword"
  ) >>"$startup_script"
else
  die "unknown shell [$shell_type] - can't initialise"
fi

## script is finished
echo "basher is installed - open a new terminal window to start using it"
