{ pkgs, ... }:

let
  colors = {
    background = "#1F1F1F";
    foreground = "#D4D4D4";
    green = "#6A9955";
    red = "#F44747";
    gray = "#808080";
    yellow = "#DCDCAA";
  };

	statusConfig = pkgs.writeText "i3status-rust.toml" ''
		[theme]
		theme = "plain"

		[theme.overrides]
		idle_bg = "${colors.background}"
		idle_fg = "${colors.foreground}"
		good_bg = "${colors.background}"
		good_fg = "${colors.green}"
		warning_bg = "${colors.background}"
		warning_fg = "${colors.yellow}"
		critical_bg = "${colors.background}"
		critical_fg = "${colors.red}"
		separator = " "
		separator_bg = "${colors.background}"
		separator_fg = "${colors.gray}"

		[icons]
		icons = "awesome6"

		[[block]]
		block = "keyboard_layout"
		driver = "sway"
		format = " $layout "

		[block.mappings]
		"English (US)" = "EN"
		"Russian" = "RU"
		"Russian (N/A)" = "RU"

		[[block]]
		block = "net"
		device = "^wl"
		format = " $icon $ssid "
		inactive_format = " $icon down "

		[[block]]
		block = "sound"
		driver = "pipewire"
		format = " $icon $volume "

		[[block]]
		block = "battery"
		format = " $icon $percentage "
		full_format = " $icon full "
		charging_format = " $icon $percentage "
		warning = 30
		critical = 15

		[[block]]
		block = "time"
		interval = 60
		format = " $icon $timestamp.datetime(f:'%a %d.%m %H:%M') "
	'';
in
{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";
      terminal = "ghostty";
			menu = "${pkgs.fuzzel}/bin/fuzzel";

      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:win_space_toggle";
        };

        "type:touchpad" = {
          tap = "enabled";
          drag = "enabled";
          dwt = "enabled";

          natural_scroll = "enabled";
          scroll_method = "two_finger";

          click_method = "clickfinger";
          tap_button_map = "lrm";

          accel_profile = "adaptive";
          pointer_accel = "0.25";
        };
      };

      output = {
        "*" = {
          bg = "${colors.background} solid_color";
        };
      };

      # Цвета окон.
      colors = {
        focused = {
          border = colors.green;
          background = colors.background;
          text = colors.foreground;
          indicator = colors.green;
          childBorder = colors.green;
        };

        focusedInactive = {
          border = colors.gray;
          background = colors.background;
          text = colors.foreground;
          indicator = colors.gray;
          childBorder = colors.gray;
        };

        unfocused = {
          border = colors.background;
          background = colors.background;
          text = colors.gray;
          indicator = colors.background;
          childBorder = colors.background;
        };

        urgent = {
          border = colors.red;
          background = colors.red;
          text = colors.background;
          indicator = colors.red;
          childBorder = colors.red;
        };

        placeholder = {
          border = colors.gray;
          background = colors.background;
          text = colors.foreground;
          indicator = colors.gray;
          childBorder = colors.gray;
        };

        background = colors.background;
      };

      bars = [
        {
          position = "top";
          mode = "dock";
          hiddenState = "hide";

					statusCommand =
						"${pkgs.i3status-rust}/bin/i3status-rs ${statusConfig}";

          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 10.0;
          };

          trayOutput = "primary";
          workspaceButtons = true;

          colors = {
            background = colors.background;
            statusline = colors.foreground;
            separator = colors.green;

            focusedWorkspace = {
              border = colors.green;
              background = colors.green;
              text = colors.background;
            };

            activeWorkspace = {
              border = colors.green;
              background = colors.background;
              text = colors.green;
            };

            inactiveWorkspace = {
              border = colors.background;
              background = colors.background;
              text = colors.gray;
            };

            urgentWorkspace = {
              border = colors.red;
              background = colors.red;
              text = colors.background;
            };

            bindingMode = {
              border = colors.yellow;
              background = colors.yellow;
              text = colors.background;
            };
          };
        }
      ];
    };

    extraConfig = ''
      # Three-finger workspace navigation
      bindgesture swipe:3:right workspace prev_on_output
      bindgesture swipe:3:left workspace next_on_output

      # Тонкие границы и небольшие промежутки.
      default_border pixel 1
      default_floating_border pixel 1

			smart_borders on
			smart_gaps on

      gaps inner 5
      gaps outer 0
    '';
  };
}
