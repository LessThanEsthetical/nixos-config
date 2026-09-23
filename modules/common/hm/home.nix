{
  flake.homeModules.home = {config, ...}: {
    home = {
      preferXdgDirectories = true;
      stateVersion = "26.05";
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
    };
  };
}
