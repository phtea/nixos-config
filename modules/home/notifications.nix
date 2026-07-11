{ pkgs, ... }:

{
	services.mako = {
		enable = true;

		settings = {
			"font" = "JetBrainsMono Nerd Font 11";

			"background-color" = "#1F1F1F";
			"text-color" = "#D4D4D4";
			"border-color" = "#6A9955";

			"border-size" = 2;
			"border-radius" = 6;
			"padding" = "12";
			"margin" = "12";

			"width" = 360;
			"height" = 120;

			"default-timeout" = 5000;
			"ignore-timeout" = false;

			"anchor" = "top-right";
			"icons" = true;
			"max-icon-size" = 48;
		};
	};

	home.packages = [
		pkgs.libnotify
	];
}
