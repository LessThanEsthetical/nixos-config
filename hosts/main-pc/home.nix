{ inputs, config, pkgs, ... }:

{
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

  xdg = {
    enable = true;

    autostart.enable = true;
    userDirs.createDirectories = true;
    userDirs.extraConfig = { BLENDER = "${config.home.homeDirectory}/Blender"; };
    mimeApps.enable = true;
    userDirs.enable = true;

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

    kitty = {
      enable = true;
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
      };
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
    };

    firefox = {
      enable = true;
      #arkenfox= {
        #enable = true;
        #version = "140.0";
      #};

      profiles.furina = {
        name = "furina";
        search.default = "ddg";
      };
    };
    neovim = {
      enable = true;
      initLua = ''
        local o = vim.o
        
	      o.relativenumber = true
        o.expandtab = true
        o.shiftwidth = 2
        o.tabstop = 2
        o.smartindent = true
        
	      vim.cmd("colorscheme industry")
      '';

      defaultEditor = true;
    };
    yt-dlp = {
      enable = true;
      
      settings = {
        progress = true;
        console-title = true;
      };
    };
  };
  home.stateVersion = "26.05";
}
