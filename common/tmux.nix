{ pkgs, ... }:

{
  programs.tmux = {
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

    plugins = with pkgs.tmuxPlugins; [
      tokyo-night-tmux battery
    ];
  };
}
