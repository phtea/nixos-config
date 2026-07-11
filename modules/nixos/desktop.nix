{ pkgs, ... }:

{
	# programs.sway.enable = true;

	services.greetd = {
		enable = true;

		settings = {
			default_session = {
				command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd sway";
				user = "greeter";
			};
		};
	};

	services.dbus.enable = true;

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
	};

	fonts.packages = with pkgs; [
		dejavu_fonts
		liberation_ttf
		nerd-fonts.jetbrains-mono
	];
}
