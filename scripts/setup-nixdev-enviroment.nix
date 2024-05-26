{ pkgs }:

pkgs.writeShellScriptBin "setup-nixdev-enviroment" ''
  #Open vscode, and terminal in directory !/nix-config
  code ~/nix-config
  cd ~/nix-config

  #Open terminal
  exec $SHELL #Their is a chance this does nothing

  #Open firefox
  firefox &
  
''