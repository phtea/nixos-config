{ config, pkgs, ... }:
 
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
 
    historyControl = [ "ignoredups" "erasedups" ];
 
    historyFileSize = 10000;
    historySize = 1000;
 
    historyIgnore = [
      "ls"
      "cd"
      "cd -"
      "pwd"
      "exit"
      "date"
      "* --help"
    ];
 
    shellOptions = [ "histappend" "globstar" ];
 
    shellAliases = {
      # Shell
      r = "exec bash";
      brc = "$EDITOR ${config.home.homeDirectory}/Projects/nixos-config/modules/home/bash.nix";
      grep = "grep --color=auto";
      ".." = "cd ..";
      n = "nvim";
      vi = "nvim";
      vim = "nvim";
 
      # Git
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph";
      gs = "git status --short";
      ga = "git add";
      gu = "git pull";
      gd = "git diff";
      gch = "git checkout";
 
      # Colored ls
      ls = "ls --color=auto";
      la = "ls -la --color=auto";
    };
 
    initExtra = ''
      # Case-insensitive completion
      bind "set completion-ignore-case on"
 
      # Search matching history entries with arrows
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
 
      # Reduce delay for terminal escape sequences
      export ESCDELAY=1
 
      # Run a command whenever matching files change.
      dowhen() {
        if [ "$#" -lt 2 ]; then
          echo "Usage: dowhen <command> <patterns...>"
          return 1
        fi
 
        if ! command -v entr >/dev/null; then
          echo "entr is required, but it is not installed."
          return 1
        fi
 
        local command="$1"
        shift
 
        (
          shopt -s globstar nullglob extglob
          printf '%s\n' "$@"
        ) | entr -r sh -c "
          clear
          echo \"[\$(date '+%H:%M:%S')] $command\"
          $command
        "
      }
 
      parse_git_branch() {
        git symbolic-ref --short HEAD 2>/dev/null | sed 's/^/ /'
      }
 
      GREEN='\[\033[01;32m\]'
      BLUE='\[\033[01;34m\]'
      RED='\[\033[31m\]'
      RESET='\[\033[00m\]'
 
      PS1="''${GREEN}\u ''${BLUE}\w''${RESET}''${RED}\$(parse_git_branch)''${RESET} "
 
      # Optional personal functions outside the Nix repository.
      if [ -f "$HOME/.bash/custom_functions" ]; then
        source "$HOME/.bash/custom_functions"
      fi
    '';
  };
 
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
 
  programs.dircolors.enable = true;
 
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
 
    LESS = "-C -M -i -n --mouse --use-color --wheel-lines=2 -j5 --incsearch";
    LESSHISTFILE = "-";
 
    COLORTERM = "truecolor";
 
  };
 
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/scripts"
  ];
 
  home.packages = with pkgs; [
    entr
    less
  ];
}
