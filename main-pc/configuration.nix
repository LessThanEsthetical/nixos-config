{ inputs, config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader.grub = {
      enable = true;
      device = "/dev/sda";
      # Set to "nodev" once you move to EFI
    };
  };

  # Enable once set on real PC
  #hardware.cpu.intel.updateMicrocode = true;

  nix = {
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
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

    openssh = {
      enable = true;
    };

    unbound = {
      enable = true;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  networking = {
    hostName = "toshi"; 
    networkmanager.enable = true;
    #networkmanager.dns = "dnsmasq";

    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
    resolvconf.enable = true;
    nftables.enable = true;
    nftables.flushRuleset = true;
  };

  time.timeZone = "Europe/Warsaw";

  users = {
    defaultUserShell = pkgs.zsh;

    users.furina = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "seat" ]; # Enable ‘sudo’ for the user.
    };
  };

  programs.zsh.enable = true;
  programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
