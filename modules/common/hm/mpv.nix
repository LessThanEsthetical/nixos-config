{
  flake.homeModules.mpv = { config, pkgs }: {
    #home.packages = [ pkgs.anime4k ];

    programs.mpv = {
      enable = true;

      scripts = builtins.attrValues { inherit (pkgs.mpvScripts) modernz sponsorblock-minimal; };
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
  };
}
