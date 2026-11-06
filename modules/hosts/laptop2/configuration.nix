{self, ...}: {
  flake.nixosModules.laptop2 = {pkgs, ...}: {
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
    };

    security.rtkit.enable = true;

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  };
}
