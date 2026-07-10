{ pkgs, ... }:

{
	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

	programs.chromium = {
		enable = true;
	};

	services.greetd = {
		enable = true;

		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd sway";
				user = "greeter";
			};
		};
	};

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
	};

	services.dbus.enable = true;

	fonts.packages = with pkgs; [
		dejavu_fonts
		liberation_ttf
		nerd-fonts.jetbrains-mono
	];
}
