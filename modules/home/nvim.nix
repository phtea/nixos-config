{ config, pkgs, ... }:
 
{
  home.packages = with pkgs; [
    neovim

		tree-sitter

    ripgrep
    fd
    lazygit
    wl-clipboard
    gcc
    unzip
    git
  ];

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Projects/nvim"; 
}
