{self, ...}: {
  flake.nixosModules.laptop2 = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.default
      self.nixosModules.firewall
      #self.nixosModules.niriwm
    ];

    boot.kernelPackages = pkgs.linuxPackages_zen;

    hardware = {
      cpu.intel.updateMicrocode = true;
      facter.reportPath = ./facter.json;
    };

    networking = {
      firewall.allowedTCPPorts = config.services.openssh.ports;
      wireless.enable = true;
    };

    users.users.defaultUser.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIU8oDEnV8WMfILylKqQUBISsArg5VRoYMRcfaTzfcmJ astolfo@moegoofy"];

    services = {
      auto-cpufreq = {
        enable = true;

        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };

      pipewire = {
        enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      libinput.enable = true;

      openssh.ports = [2999];
    };

    security.rtkit.enable = true;

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  };
}
