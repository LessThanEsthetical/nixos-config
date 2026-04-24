{ config, pkgs, ... }:

{
  home.packages = [ pkgs.anime4k ];

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [ modernz  sponsorblock-minimal ];
    config = {
      ao = "pipewire";
      deband = true;
      sub-auto = "fuzzy";
      screenshot-format = "png";
      screenshot-png-compression = 9;
      screenshot-dir = "${config.xdg.userDirs.pictures}/mpv";
      hr-seek = "absolute";
      scale-antiring = 0.6;
    };
    bindings = { 
      WHEEL_UP = "add volume +5";
      WHEEL_DOWN = "add volume -5";
    };
  };

  # Turn this on when Jellyfin server will be set up
  services.jellyfin-mpv-shim = {
    enable = false;
  };
}
