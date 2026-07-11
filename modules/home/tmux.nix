{ config, pkgs, ... }:

let
  tmuxHere = pkgs.writeShellApplication {
    name = "tmux-here";

    runtimeInputs = [
      pkgs.tmux
      pkgs.coreutils
    ];

    text = ''
      dir="$(cd "$PWD" && pwd -P)"
      session_name="$(basename "$dir")"

      if tmux has-session -t "$session_name" 2>/dev/null; then
        if [[ -n "''${TMUX:-}" ]]; then
          tmux switch-client -t "$session_name"
        else
          tmux attach-session -t "$session_name"
        fi
      else
        if [[ -n "''${TMUX:-}" ]]; then
          tmux new-session -d -s "$session_name" -c "$dir"
          tmux switch-client -t "$session_name"
        else
          tmux new-session -s "$session_name" -c "$dir"
        fi
      fi
    '';
  };

  tmuxSessionizer = pkgs.writeShellApplication {
    name = "tmux-sessionizer";

    runtimeInputs = [
      pkgs.tmux
      pkgs.fzf
      pkgs.gawk
      pkgs.coreutils
    ];

    text = ''
      frecency_file="''${XDG_STATE_HOME:-$HOME/.local/state}/tmux-session-frecency"

      mkdir -p "$(dirname "$frecency_file")"
      touch "$frecency_file"

      current=""
      if [[ -n "''${TMUX:-}" ]]; then
        current="$(tmux display-message -p '#S')"
      fi

      selected="$(
        tmux list-sessions -F '#{session_name}' 2>/dev/null |
          awk -v current="$current" '$0 != current' |
          awk -v file="$frecency_file" '
            BEGIN {
              while ((getline < file) > 0)
                score[$1] = $2
            }
            {
              printf "%6d  %s\n", score[$0] + 0, $0
            }
          ' |
          sort -rn |
          fzf \
            --info=hidden \
            --delimiter=' ' \
            --color='bg+:-1,fg+:#ffffff' \
            --padding=6,30 \
            --prompt='Session  ' \
            --pointer=' ' \
            --with-nth=2.. |
          awk '{print $NF}'
      )"

      [[ -z "$selected" ]] && exit 0

      now="$(date +%s)"
      tmp="$(mktemp)"

      awk -v selected="$selected" -v now="$now" '
        $1 == selected {
          age_days = (now - $3) / 86400
          decay = 0.95 ^ age_days
          $2 = int(($2 * decay) + 100)
          $3 = now
          seen = 1
        }

        { print }

        END {
          if (!seen)
            print selected, 100, now
        }
      ' "$frecency_file" > "$tmp"

      mv "$tmp" "$frecency_file"

      if [[ -n "''${TMUX:-}" ]]; then
        tmux switch-client -t "$selected"
      else
        tmux attach-session -t "$selected"
      fi
    '';
  };
in
{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    escapeTime = 0;
    focusEvents = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g status-interval 0

      setw -g pane-base-index 1
      set-option -g renumber-windows on

      # Clipboard integration for Wayland.
      bind -T copy-mode-vi y \
        send -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"

      bind -T copy-mode-vi Space \
        send -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"

      bind -T copy-mode-vi MouseDragEnd1Pane \
        send -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"

      # Reload config.
      bind r source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf \
        \; display-message "Sourced config!"

      # Session management.
      bind f display-popup -B -E "${tmuxSessionizer}/bin/tmux-sessionizer"
      bind -n M-f display-popup -B -E "${tmuxSessionizer}/bin/tmux-sessionizer"

      bind -n F3 switch-client -l
      bind t switch-client -t tasks
      bind -n F4 last-window

      # Capture full pane into Neovim.
      bind v capture-pane -S - \
        \; save-buffer /tmp/tmux \
        \; delete-buffer \
        \; new-window -n "vim-tmux-capture" -c "#{pane_current_path}" \
          "nvim /tmp/tmux && rm -f /tmp/tmux; tmux kill-window"

      # Vim-style copy mode.
      bind -T copy-mode-vi v send -X begin-selection

      # Prefix pane navigation.
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Alt + number window switching.
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-z resize-pane -Z

      # Alt pane navigation.
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Status line.
      set -g status-position top
      set -g status-style bg=default
      set -g status-left-length 30
      set -g status-left "#[fg=#888888,bold]#S "
      set -g status-right "#{?window_zoomed_flag, z,}"

      set -g window-status-separator " "
      setw -g window-status-format "#[fg=#888888]#I:#W"
      setw -g window-status-current-format "#[fg=#DDDDDD]#I:#W"
    '';
  };

  home.packages = [
    tmuxHere
    tmuxSessionizer
  ];

  programs.bash.shellAliases.t = "tmux-here";
}
