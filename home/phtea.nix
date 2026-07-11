{ pkgs, ... }:

{

	imports = [
		../modules/home/bash.nix
		../modules/home/sway.nix
		../modules/home/ghostty.nix
		../modules/home/chromium.nix
		../modules/home/nvim.nix
		../modules/home/notifications.nix
		../modules/home/screenshots.nix
		../modules/home/fuzzel.nix
		../modules/home/lazygit.nix
		../modules/home/tmux.nix

		../modules/home/telegram.nix
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
	];
}
