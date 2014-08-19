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
for cmd in (basher commands)
  complete -f -c basher -n "__fish_basher_using_command $cmd" -a "(basher completions $cmd)"
end
