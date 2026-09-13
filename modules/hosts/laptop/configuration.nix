{self, ...}: {
  flake.nixosModules.laptop = {pkgs, ...}: {
    imports = [
      self.nixosModules.configuration
      self.nixosModules.firewall
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      loader.efi.canTouchEfiVariables = false;
      loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        memtest86.enable = true;
        efiInstallAsRemovable = true; # Due to specifics of my laptop, this is required
      };
    };

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
        pulse.enable = true;
      };
    };

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  };
}
