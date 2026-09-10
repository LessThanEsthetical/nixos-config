{inputs, ...}: {
  flake.homeModules.niriwm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    input = builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/e8/wallhaven-e8wdxl.png";
      name = "wallpaper.png";
      sha256 = "sha256-jravNZgpmi90qsivxLk+kaOsi0fgf6K//t3cL1c263w=";
    };

    wallpaper = pkgs.runCommand "wallpaper.png" {} ''
      ${lib.getExe' pkgs.libjxl "cjxl"} -d 0 -e 9 ${input} $out
    '';
  in {
    imports = [inputs.niri.homeModules.niri];
    programs.niri = {
      enable = true;

      package = pkgs.niri;
      settings = {
        prefer-no-csd = true;
        screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/screenshot_%d-%m-%Y_%H-%M-%S.png";
        spawn-at-startup = [
          {argv = ["${lib.getExe pkgs.swaybg}" "-m" "fit" "-i" "${wallpaper}"];}
        ];
        binds = {
          "Mod+Shift+Slash".action.show-hotkey-overlay = [];
          "Mod+Shift+E".action.quit.skip-confirmation = false;
          "Mod+Shift+P".action.power-off-monitors = [];
          "Mod+Escape" = {
            allow-inhibiting = false;
            action.toggle-keyboard-shortcuts-inhibit = [];
          };
          "Mod+Q" = {
            repeat = false;
            action.close-window = [];
          };
          "Mod+O" = {
            repeat = false;
            action.toggle-overview = [];
          };
          "Mod+T".action.spawn = "alacritty";
          "Mod+D".action.spawn = "fuzzel";
          "Ctrl+L".action.spawn = "swaylock";

          "Mod+Print".action.screenshot-screen.show-pointer = false;
          "Mod+Ctrl+Print".action.screenshot-window = [];

          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe' pkgs.wireplumber "wpctl"}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe' pkgs.wireplumber "wpctl"}" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
          };

          "XF86AudioPlay" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.playerctl}" "play-pause"];
          };
          "XF86AudioPause" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.playerctl}" "play-pause"];
          };
          "XF86AudioStop" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.playerctl}" "stop"];
          };
          "XF86AudioPrev" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.playerctl}" "previous"];
          };
          "XF86AudioNext" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.playerctl}" "next"];
          };

          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.brightnessctl}" "-c" "backlight" "set" "+10%"];
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = ["${lib.getExe pkgs.brightnessctl}" "-c" "backlight" "set" "10%-"];
          };

          # Focusing on columns and windows
          "Mod+Left".action.focus-column-left = [];
          "Mod+H".action.focus-column-left = [];
          "Mod+WheelScrollLeft".action.focus-column-left = [];
          "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
          "Mod+Down".action.focus-window-down = [];
          "Mod+J".action.focus-window-down = [];
          "Mod+Up".action.focus-window-up = [];
          "Mod+K".action.focus-window-up = [];
          "Mod+Right".action.focus-column-right = [];
          "Mod+L".action.focus-column-right = [];
          "Mod+WheelScrollRight".action.focus-column-right = [];
          "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
          "Mod+Home".action.focus-column-first = [];
          "Mod+End".action.focus-column-last = [];

          # Moving columns and windows
          "Mod+Ctrl+Left".action.move-column-left = [];
          "Mod+Ctrl+H".action.move-column-left = [];
          "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];
          "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];
          "Mod+Ctrl+Down".action.move-window-down = [];
          "Mod+Ctrl+J".action.move-window-down = [];
          "Mod+Ctrl+Up".action.move-window-up = [];
          "Mod+Ctrl+K".action.move-window-up = [];
          "Mod+Ctrl+Right".action.move-column-right = [];
          "Mod+Ctrl+L".action.move-column-right = [];
          "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
          "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
          "Mod+Ctrl+Home".action.move-column-to-first = [];
          "Mod+Ctrl+End".action.move-column-to-last = [];

          # Focusing on monitors
          "Mod+Shift+Left".action.focus-monitor-left = [];
          "Mod+Shift+H".action.focus-monitor-left = [];
          "Mod+Shift+Down".action.focus-monitor-down = [];
          "Mod+Shift+J".action.focus-monitor-down = [];
          "Mod+Shift+Up".action.focus-monitor-up = [];
          "Mod+Shift+K".action.focus-monitor-up = [];
          "Mod+Shift+Right".action.focus-monitor-right = [];
          "Mod+Shift+L".action.focus-monitor-right = [];

          # Moving columns to monitors
          "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
          "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
          "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
          "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
          "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
          "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
          "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
          "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

          # Focusing on workspaces
          "Mod+Page_Up".action.focus-workspace-up = [];
          "Mod+I".action.focus-workspace-up = [];
          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            action.focus-workspace-up = [];
          };
          "Mod+Page_Down".action.focus-workspace-down = [];
          "Mod+U".action.focus-workspace-down = [];
          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            action.focus-workspace-down = [];
          };
          "Mod+Shift+Page_Up".action.move-workspace-up = [];
          "Mod+Shift+I".action.move-workspace-up = [];
          "Mod+Shift+Page_Down".action.move-workspace-down = [];
          "Mod+Shift+U".action.move-workspace-down = [];
          "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
          "Mod+Ctrl+I".action.move-column-to-workspace-up = [];
          "Mod+Ctrl+WheelScrollUp" = {
            cooldown-ms = 150;
            action.move-column-to-workspace-up = [];
          };
          "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
          "Mod+Ctrl+O".action.move-column-to-workspace-down = [];
          "Mod+Ctrl+WheelScrollDown" = {
            cooldown-ms = 150;
            action.move-column-to-workspace-down = [];
          };

          # Focus and move workspaces based on index from 1 to 9
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+Ctrl+1".action.move-column-to-workspace = 1;
          "Mod+Ctrl+2".action.move-column-to-workspace = 2;
          "Mod+Ctrl+3".action.move-column-to-workspace = 3;
          "Mod+Ctrl+4".action.move-column-to-workspace = 4;
          "Mod+Ctrl+5".action.move-column-to-workspace = 5;
          "Mod+Ctrl+6".action.move-column-to-workspace = 6;
          "Mod+Ctrl+7".action.move-column-to-workspace = 7;
          "Mod+Ctrl+8".action.move-column-to-workspace = 8;
          "Mod+Ctrl+9".action.move-column-to-workspace = 9;

          "Mod+BracketLeft".action.consume-or-expel-window-left = [];
          "Mod+BracketRight".action.consume-or-expel-window-right = [];
          "Mod+Comma".action.consume-window-into-column = [];
          "Mod+Period".action.expel-window-from-column = [];
          "Mod+R".action.switch-preset-column-width = [];
          "Mod+Shift+R".action.switch-preset-column-width-back = [];
          "Mod+Ctrl+R".action.switch-preset-window-height = [];
          "Mod+Ctrl+Shift+R".action.reset-window-height = [];
          "Mod+F".action.maximize-column = [];
          "Mod+Shift+F".action.fullscreen-window = [];
          "Mod+C".action.center-column = [];
          "Mod+Ctrl+C".action.center-visible-columns = [];
          "Mod+M".action.maximize-window-to-edges = [];
          "Mod+W".action.toggle-column-tabbed-display = [];
          "Mod+V".action.toggle-window-floating = [];
          "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

          "Mod+Minus".action.set-column-width = "-10%";
          "Mod+Equal".action.set-column-width = "+10%";
          "Mod+Shift+Minus".action.set-window-height = "-10%";
          "Mod+Shift+Equal".action.set-window-height = "+10%";
        };
      };
    };

    xdg.portal = {
      enable = true;

      extraPortals = [pkgs.xdg-desktop-portal-gnome];
      xdgOpenUsePortal = true;
    };
  };
}
