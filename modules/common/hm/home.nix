{ config, ... }:

{
  flake.homeModules.home = { config, pkgs, ... }: {
    home = {
      #username = "${config.username}";
      #homeDirectory = "/home/${config.username}";
      shell.enableZshIntegration = true;
      preferXdgDirectories = true;
    };

    services = { 
      gammastep = {
        enable = true;
        provider = "manual";
        latitude = 52.2;
        longitude = 21.0;
      };

      cliphist = {
        enable = true;

        allowImages = true;
      };
    };

    fonts.fontconfig = {
      enable = true;

      hinting = "slight";
      subpixelRendering = "rgb";
      antialiasing = true;

      defaultFonts = {
        emoji = [ "pkgs.font-awesome" ];
        monospace = [ "pkgs.nerd-fonts.jetbrains-mono" ];
        sansSerif = [ "pkgs.inter-nerdfont" ];
      };
    };

    xdg = {
      enable = true;

      autostart.enable = true;
      mimeApps.enable = true;
      configFile."mimeapps.list".force = true;
      userDirs = { 
        enable = true;

        createDirectories = true;
        setSessionVariables = true;
        extraConfig = { 
	BLENDER = "${config.home.homeDirectory}/Blender";
	PROJECTS = "${config.home.homeDirectory}/Projects";
	};
      };
    };

    programs = {
      git = {
        enable = true;
        settings.user = {
          name = "furina";
          email = "furina@example.com";
# Change after setting on real VM
        };
      };

      nh = {
        enable = true;

      };

      kitty = {
        enable = true;

        enableGitIntegration = true;  
        themeFile = "tokyo_night_storm";
        shellIntegration.enableZshIntegration = true;
        font = {
#package = [ pkgs.nerd-fonts.fira-code ];
          name = "FiraCode Nerd Font Mono";
          size = 11;
        };
        settings = {
          cursor_shape = "underline";
          cursor_trail = 1;
          enable_audio_bell = "no";
          background_opacity = 0.75;
        };
      };

      neovim = {
        enable = true;

        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        initLua = ''
          local o = vim.o

          o.relativenumber = true
          o.expandtab = true
          o.shiftwidth = 2
          o.tabstop = 2
          o.smartindent = true

          vim.cmd("colorscheme industry")
          '';
      };
      yt-dlp = {
        enable = true;

        settings = {
          paths = "home:${config.xdg.userDirs.download}/webvids";
          output = "%(extractor)s/%(title)s [%(id)s].%(ext)s";

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
    home.stateVersion = "26.05";
  };
}
