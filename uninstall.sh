#!/usr/bin/env bash

die() {
  echo "!! $1 " >&2
  echo "!! -----------------------------" >&2
  exit 1
}

xdg_basher_dir="${XDG_DATA_HOME:-$HOME/.local/share}/basher"

## stop if basher is not installed
[[ -d "$HOME/.basher" || -d "$xdg_basher_dir" ]] || die "basher doesn't seem to be installed on [$HOME/.basher] or [$xdg_basher_dir]"
echo ". remove basher code and installed packages"
basher list
sleep 2
[ -d "$HOME/.basher" ] && rm -fr "$HOME/.basher"
[ -d "$xdg_basher_dir" ] && rm -fr "$xdg_basher_dir"

## now check what shell is running
shell_type=$(basename "$SHELL")
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

echo ". following basher folders are in your path:"
echo $PATH | tr ':' "\n" | grep basher

if grep -q "$basher_keyword" "$startup_script" ; then
  echo ". remove basher from startup script [$startup_script]"
  sleep 1
  temp_file="$startup_script.temp"
  cp "$startup_script" "$temp_file"
  < "$temp_file" grep -v "$basher_keyword" > "$startup_script"
  rm "$temp_file"
elif grep -q basher "$startup_script" ; then
    grep basher "$startup_script"
    die "Can't auto-remove the lines from $(basename $startup_script) - please do so manually "
else
    die "Can't find initialisation commands for basher"
fi

## script is finished
echo "basher is uninstalled"
