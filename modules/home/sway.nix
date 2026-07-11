{ ... }:
 
{
  wayland.windowManager.sway = {
    enable = true;
 
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
 
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
          bg = "#1F1F1F solid_color";
        };
      };
    };
 
    extraConfig = ''
      # Three-finger workspace navigation
      bindgesture swipe:3:right workspace prev_on_output
      bindgesture swipe:3:left workspace next_on_output
    '';
  };
}
