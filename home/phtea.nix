{ pkgs, ... }:

{

	imports = [
		../modules/home/bash.nix
		../modules/home/sway.nix
		../modules/home/ghostty.nix
		../modules/home/firefox.nix
		../modules/home/nvim.nix
	];

	home.username = "phtea";
	home.homeDirectory = "/home/phtea";

	home.stateVersion = "26.05";

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		git

		ripgrep
		fd

		tree
		htop
		curl
		wget

		tmux
	];
}
