{ ... }:

{
  programs.waybar = {
    enable = true;

    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "clock" ];

        "clock" = {
          format = "{:%H:%M:%S}";
          interval = 1;
        };
      };
    };
  };
}
