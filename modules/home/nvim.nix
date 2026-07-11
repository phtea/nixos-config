{ config, pkgs, ... }:
 
{
  home.packages = with pkgs; [
    neovim

		tree-sitter

    ripgrep
    fd
    wl-clipboard
    gcc
    unzip
  ];

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Projects/nvim"; 
}
