{
  flake.homeModules.wallpapers = {
    config,
    pkgs,
    ...
  }: let
    awwwscript = pkgs.writeShellApplication {
      name = "awww.sh";
      runtimeInputs = [pkgs.fd pkgs.awww];
      text = ''
        awww img -- "$(fd -a0tf . ${config.xdg.userDirs.pictures}/whvn/desktop | shuf -zn1)"
      '';
    };
  in {
    systemd.user = {
      services = {
        awww = {
          Unit = {
            Description = "awww service with timer";
            Documentation = "man:awww(1)";
          };
          Service = {
            ExecStart = "${awwwscript}";
          };
        };
      };
      timers = {
        awww = {
          Unit = {
            Description = "Change wallpaper every 15-30 minutes";
          };
          Timer = {
            OnBootSec = "10min";
            OnUnitActiveSec = "15min";
            RandomizedDelaySec = "10min";
            FixedRandomDelay = "true";
          };
          Install = {
            WantedBy = ["timers.target"];
          };
        };
      };
    };
  };
}
