{ pkgs }:

pkgs.writeShellScriptBin "setup-nixdev-enviroment" ''
  #Open vscode, and terminal in directory !/nix-config
  code ~/nix-config
  cd ~/nix-config

  #Open terminal
  exec $SHELL

  #Open firefox
  firefox
  
''