{ self, modulesPath, ... }:

{
  flake.nixosModules.pc = { inputs, pkgs, modulesPath, ... }: {

    imports = [
     #self.nixosModules.configuration 
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      loader.efi.canTouchEfiVariables = true;
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

    environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/44446016-47e8-4c69-91c3-256b237c20aa";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/12CE-A600";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
    };
    swapDevices = [ { device = "/dev/disk/by-uuid/06ced088-af37-4577-9365-6c613555be1c"; } ];
  };
}
