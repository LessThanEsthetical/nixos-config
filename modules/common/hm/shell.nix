{
  flake.homeModules.shell = {pkgs, ...}: {
    programs = {
      zsh = {
        enable = true;

        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
          expireDuplicatesFirst = true;
          ignoreSpace = true;
        };

        shellAliases = {
          check = "fastfetch";
          ls = "eza --color=auto";
          stfu = "systemctl poweroff";
          gs = "git status";
        };

        siteFunctions = {
          # Create and navigate into directory immediately
          mkcd = ''
            mkdir -p -- "$1" && cd -P -- "$1"
          '';
          # Copy image from web as image
          cpimg = ''
            wget -qO- -- "$1" | wl-copy
          '';
          # yazi file manager thing
          y = ''
                   local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            IFS= read -r -d \'\' cwd < "$tmp"
            [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
            rm -f -- "$tmp"
          '';
        };
      };

      starship = {
        enable = true;

        enableZshIntegration = true;
      };

      tmux = {
        enable = true;

        aggressiveResize = true;
        baseIndex = 1;
        clock24 = true;
        mouse = true;
        historyLimit = 10000;
        secureSocket = true;
        terminal = "tmux-256color";
        keyMode = "vi";
        escapeTime = 0;
        newSession = true;

        plugins = builtins.attrValues {inherit (pkgs.tmuxPlugins) tokyo-night-tmux battery;};
      };

      fzf = {
        enable = true;

        tmux.enableShellIntegration = true;
        enableZshIntegration = true;
      };

      yazi = {
        enable = true;

        enableZshIntegration = true;
      };
    };
  };
}
