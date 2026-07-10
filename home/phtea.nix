{ pkgs, ... }:

{
	home.username = "phtea";
	home.homeDirectory = "/home/phtea";

	home.stateVersion = "26.05";

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		git
		neovim

		ripgrep
		fd

		tree
		htop
		curl
		wget

		ghostty
	];
}
