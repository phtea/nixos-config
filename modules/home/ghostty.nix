{ ... }:
 
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    installVimSyntax = true;
 
    settings = {
      theme = "phtea-vscode-dark";
 
      window-decoration = "none";
      window-show-tab-bar = "never";
 
      font-feature = [ "-calt" "-dlig" "-liga" ];
 
      keybind = [
        "alt+digit_1=text:\\x1b1"
        "alt+digit_2=text:\\x1b2"
        "alt+digit_3=text:\\x1b3"
        "alt+digit_4=text:\\x1b4"
        "alt+digit_5=text:\\x1b5"
        "alt+digit_6=text:\\x1b6"
        "alt+digit_7=text:\\x1b7"
        "alt+digit_8=text:\\x1b8"
        "alt+digit_9=text:\\x1b9"
        "alt+digit_0=text:\\x1b0"
 
        "ctrl+shift+key_c=copy_to_clipboard"
        "ctrl+shift+key_v=paste_from_clipboard"
      ];
    };
 
    themes.phtea-vscode-dark = {
      background = "1F1F1F";
      foreground = "D4D4D4";
      cursor-color = "D4D4D4";
 
      selection-background = "264F78";
      selection-foreground = "FFFFFF";
 
      palette = [
        "0=#1F1F1F"
        "1=#F44747"
        "2=#6A9955"
        "3=#DCDCAA"
        "4=#569CD6"
        "5=#C586C0"
        "6=#56B6C2"
        "7=#D4D4D4"
 
        "8=#808080"
        "9=#F44747"
        "10=#6A9955"
        "11=#DCDCAA"
        "12=#569CD6"
        "13=#C586C0"
        "14=#56B6C2"
        "15=#D4D4D4"
      ];
    };
  };
}
