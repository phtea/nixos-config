{ config, lib, pkgs, ... }:

let
  screenshotArea = pkgs.writeShellScriptBin "screenshot-area" ''
    set -euo pipefail

    directory="${config.home.homeDirectory}/Pictures/Screenshots"
    mkdir -p "$directory"

    filename="$directory/$(date '+%Y-%m-%d_%H-%M-%S').png"
    geometry="$(${pkgs.slurp}/bin/slurp)"

    # slurp завершится без результата при Escape.
    [ -n "$geometry" ] || exit 0

    ${pkgs.grim}/bin/grim -g "$geometry" - \
      | ${pkgs.coreutils}/bin/tee "$filename" \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png

    ${pkgs.libnotify}/bin/notify-send \
      "Скриншот области" \
      "Сохранён в $filename"
  '';

  screenshotFull = pkgs.writeShellScriptBin "screenshot-full" ''
    set -euo pipefail

    directory="${config.home.homeDirectory}/Pictures/Screenshots"
    mkdir -p "$directory"

    filename="$directory/$(date '+%Y-%m-%d_%H-%M-%S').png"

    ${pkgs.grim}/bin/grim - \
      | ${pkgs.coreutils}/bin/tee "$filename" \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png

    ${pkgs.libnotify}/bin/notify-send \
      "Скриншот экрана" \
      "Сохранён в $filename"
  '';
in
{
  home.packages = [
    screenshotArea
    screenshotFull

    # Полезно иметь команды доступными и вручную.
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  wayland.windowManager.sway.config.keybindings =
    lib.mkOptionDefault {
      "Print" = "exec ${screenshotArea}/bin/screenshot-area";
      "Shift+Print" = "exec ${screenshotFull}/bin/screenshot-full";
    };
}
