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

in
{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";
      terminal = "ghostty";
			menu = "${pkgs.fuzzel}/bin/fuzzel";
			bars = [];

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

      gaps inner 10
      gaps outer 0
    '';
  };

	programs.waybar = {
		enable = true;
		systemd.enable = true;

		settings = {
			mainBar = {
				layer = "top";
				position = "bottom";
				height = 28;

				modules-left = [ "sway/workspaces" ];

				modules-right = [
					"tray"
					"sway/language"
					"network"
					"pulseaudio"
					"battery"
					"clock"
				];

				"sway/workspaces" = {
					disable-scroll = true;
					all-outputs = false;
					format = "{name}";
				};

				"sway/language" = {
					format = "{shortDescription}";
				};

				# TODO delete
				keyboard-state = {
					numlock = false;
					capslock = false;
					format = {
						locked = " {name} ";
						unlocked = " {name} ";
					};
				};

				network = {
					interface = "wl*";
					format-wifi = "   {essid} ";
					format-ethernet = " 󰈀  {ipaddr} ";
					format-disconnected = " 󰖪  down ";
					tooltip-format-wifi = "{ifname}: {essid}\n{ipaddr}";
				};

				tray = {
					icon-size = 16;
					spacing = 6;
				};

				pulseaudio = {
					format = " {icon} {volume}% ";
					format-muted = " 󰝟 muted ";
					format-icons = {
						default = [ "" "" "" ];
					};

					on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
				};

				battery = {
					states = {
						warning = 30;
						critical = 15;
					};

					format = " {icon} {capacity}% ";
					format-charging = " 󰂄 {capacity}% ";
					format-full = " 󰁹 {capacity}% ";

					format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
				};

				clock = {
					interval = 60;
					format = " 󰥔 {:%a %d.%m %H:%M} ";
					tooltip-format = "<tt>{calendar}</tt>";
				};
			};
		};

		style = ''
		* {
			border: none;
			border-radius: 0;
			min-height: 0;
			font-family: "JetBrainsMono Nerd Font";
			font-size: 14px;
		}

		window#waybar {
			background: ${colors.background};
			color: ${colors.foreground};
		}

		#workspaces button {
			padding: 0 6px;
			background: ${colors.background};
			color: ${colors.gray};
		}

		#workspaces button.focused {
			background: ${colors.green};
			color: ${colors.background};
		}

		#workspaces button.urgent {
			background: ${colors.red};
			color: ${colors.background};
		}

		#language,
		#network,
		#tray,
		#pulseaudio,
		#battery,
		#clock {
			padding: 0 4px;
			background: ${colors.background};
			color: ${colors.foreground};
		}

		#network.disconnected,
		#pulseaudio.muted {
			color: ${colors.gray};
		}

		#battery.warning {
			color: ${colors.yellow};
		}

		#battery.critical {
			color: ${colors.red};
		}

		#tray {
			margin-right: 2px;
		}
	'';
	};
}
