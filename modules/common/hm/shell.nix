{
  flake.homeModules.shell = {
    pkgs,
    lib,
    osConfig,
    ...
  }: {
    programs = {
      zsh = lib.mkIf osConfig.programs.zsh.enable {
        enable = true;

        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
          expireDuplicatesFirst = true;
          ignoreSpace = true;
        };

        shellAliases = {
          check = "fastfetch";
          stfu = "shutdown -P 0";
          gs = "git status";
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
    };
  };
}
