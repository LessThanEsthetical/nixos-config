{
  flake.homeModules.media = {
    config,
    pkgs,
  }: {
    #home.packages = [ pkgs.anime4k ];

    programs = {
      mpv = {
        enable = true;

        scripts = builtins.attrValues {inherit (pkgs.mpvScripts) modernz sponsorblock-minimal;};
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

        yt-dlp = {
          enable = true;

          settings = {
            paths = [
              "\"home:${config.xdg.userDirs.download}/webvids\""
              "\"temp:tmp\""
            ];
            output = "\"%(extractor)s/%(title)s [%(id)s].%(ext)s\"";

            impersonate = "chrome:windows-10";
            force-keyframes-at-cuts = true;
            sponsorblock-mark = "all";
            sponsorblock-remove = "sponsor";
            external-downloader = "aria2c";
            no-write-comments = true;
            convert-thumbnails = "png";
            sub-langs = "all";
            sub-format = "best";
            no-windows-filenames = true;

            progress = true;
            console-title = true;

            embed-thumbnail = true;
            embed-metadata = true;
            embed-info-json = true;
            embed-chapters = true;
            embed-subs = true;
          };
        };
      };
    };
  };
}
