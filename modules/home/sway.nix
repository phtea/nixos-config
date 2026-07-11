{ ... }:

{
	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;

		config = {
			terminal = "ghostty";
			modifier = "Mod4";

			input = {
				"*" = {
					xkb_layout = "us,ru";
					xkb_options = "grp:win_space_toggle";
				};
			};

			# TODO:
			# bars = {
			# 	position = "top";
			# };
		};
	};
}
