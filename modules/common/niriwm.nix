{ inputs, ... }:

{
  flake.homeModules.niriwm = { config, pkgs, ... }: {
    imports = [ inputs.niri.homeModules.niri ];

    programs.niri = {
      enable = true;

      package = pkgs.niri;
      settings = {
        prefer-no-csd = true;
        screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/screenshot_%d-%m-%Y_%H-%M-%S.png";
        #spawn-at-startup = [ { argv = ["waybar"]; } ];
        binds = {
          "Mod+Shift+Slash".action.show-hotkey-overlay = [];
          "Mod+Shift+E".action.quit.skip-confirmation = false;
          "Mod+T".action.spawn = "kitty";
          "Mod+D".action.spawn = "fuzzel";
          "Mod+Y".action.screenshot-screen = { show-pointer = false; };
        };
      };
    };

    xdg.portal = {
      enable = true;

      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      xdgOpenUsePortal = true;
    };
  };
}
