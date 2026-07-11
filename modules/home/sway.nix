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

  i3statusConfig = pkgs.writeText "i3status.conf" ''
    general {
      colors = true
      interval = 2

      color_good = "${colors.green}"
      color_degraded = "${colors.yellow}"
      color_bad = "${colors.red}"
    }

    order += "wireless _first_"
    order += "volume master"
    order += "battery all"
    order += "tztime local"

    wireless _first_ {
      format_up = "Wi-Fi: %quality at %essid"
      format_down = "Wi-Fi: down"
    }

    volume master {
      format = "Vol: %volume"
      format_muted = "Vol: muted"
      device = "default"
      mixer = "Master"
      mixer_idx = 0
    }

    battery all {
      format = "Bat: %percentage"
      format_down = "Bat: ?"
      status_chr = "CHR"
      status_bat = "BAT"
      status_full = "FULL"
      low_threshold = 15
    }

    tztime local {
      format = "%a %d.%m  %H:%M"
    }
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
            "${pkgs.i3status}/bin/i3status -c ${i3statusConfig}";

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
