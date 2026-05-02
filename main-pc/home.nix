{ inputs, config, pkgs, ... }:

{

  imports = [ 
    ../common/hyprland.nix
    ../common/misc.nix
    ../common/mpv.nix
    ../common/starship.nix
    ../common/tmux.nix
    ../common/firefox.nix
  ];

  home = {
    username = "furina";
    homeDirectory = "/home/furina";
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
    userDirs = { 
      enable = true;

      createDirectories = true;
      extraConfig = { BLENDER = "${config.home.homeDirectory}/Blender"; };
    };
    portal = {
      enable = true;

      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      xdgOpenUsePortal = true;
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

      flake = "/home/furina/nixos-conf";
      clean = {
        enable = false;
        extraArgs = "--keep";
      };
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
  
    zsh = {
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
        output = "%(extractor)s/%(title)s [%(id)s].$(ext)s";

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
}
