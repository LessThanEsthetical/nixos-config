{self, ...}: {
  flake.nixosModules.vm = {
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      self.nixosModules.configuration
      self.nixosModules.firewall
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      loader.efi.canTouchEfiVariables = false;
      loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
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
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
    };

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  };
}
