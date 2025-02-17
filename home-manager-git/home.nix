{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    git
    fzf
    blueberry
    neovim #git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
    gcc

    (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
        ];
    })
  ];

  programs.git = {
    enable = true;
    userName = "Daniel Denisov";
    userEmail = "git@danieldenisov.com";
    aliases = {
      ci = "commit";
      co = "checkout";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
