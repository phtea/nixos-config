{ ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        terminal = "ghostty -e";
        layer = "overlay";

        width = 40;
        lines = 10;
        horizontal-pad = 20;
        vertical-pad = 12;
        inner-pad = 8;

        icon-theme = "hicolor";
        icons-enabled = true;
        fuzzy = true;

        prompt = "❯";
        placeholder = "Search...";
        hide-before-typing = false;
      };

      colors = {
        background = "1f1f1fff";
        text = "d4d4d4ff";
        prompt = "6a9955ff";
        placeholder = "808080ff";

        input = "d4d4d4ff";
        match = "6a9955ff";

        selection = "264f78ff";
        selection-text = "ffffffff";
        selection-match = "6a9955ff";

        counter = "808080ff";
        border = "6a9955ff";
      };

      border = {
        width = 2;
        radius = 6;
      };

      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
