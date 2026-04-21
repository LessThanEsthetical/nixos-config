{ ... }:

{
  imports = [
    ./dunst.nix
    ./rofi.nix
    ./polybar.nix
  ];

  #wayland.windowManager.hyprland = {
    #enable = true;

    #systemd.enableXdgAutostart = true;
    #xwayland.enable = true;
  #};

  services = {
    #hyprsunset.enable = true;
    hyprpolkitagent.enable = true;
    hyprpaper.enable = true;
    hypridle.enable = true;
  };

  programs = {
    hyprlock.enable = true;
    hyprshot.enable = true;
  };
}
