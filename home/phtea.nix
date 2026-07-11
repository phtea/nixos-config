{ pkgs, ... }:

{

	imports = [
		../modules/home/bash.nix
		../modules/home/sway.nix # TODO: remove foot from sway
		../modules/home/ghostty.nix
		../modules/home/chromium.nix
		../modules/home/nvim.nix
		../modules/home/notifications.nix
		../modules/home/screenshots.nix
		../modules/home/fuzzel.nix
		../modules/home/lazygit.nix
		../modules/home/tmux.nix
		# TODO: add icons to the bar + current language
		# TODO: docker, lua, nix lsps and tools
		# TODO: sounds
	];

	home.username = "phtea";
	home.homeDirectory = "/home/phtea";

	home.stateVersion = "26.05";

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		# cli
		git
		tree
		htop
		curl
		wget
		fastfetch

		# gui
		telegram-desktop
	];
}
