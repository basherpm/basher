function __fish_basher_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'basher' ]
    return 0
  end
  return 1
end

function __fish_basher_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c basher -n '__fish_basher_needs_command' -a '(basher commands)'
set --local basher_commands commands completions help init \
    install link list outdated package-path uninstall update upgrade
for cmd in $basher_commands
  complete -f -c basher -n "__fish_basher_using_command $cmd" -a "(basher completions $cmd)"
end
