{ inputs, config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
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

      ports = [ 3620 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
	      AllowUsers = [ "furina" ];
      };
    };

    unbound = {
      enable = true;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  networking = {
    hostName = "toshi"; 
    networkmanager.enable = true;
    #networkmanager.dns = "dnsmasq";

    #firewall.enable = true;
    #firewall.allowedTCPPorts = [ 22 ];
    resolvconf.enable = true;
    nftables.enable = true;
    nftables.flushRuleset = true;
  };

  # Why yes, I'm influenced
  time.timeZone = "Asia/Tokyo";

  users = {
    defaultUserShell = pkgs.zsh;

    users.furina = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "seat" ];
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2Ld4FLFrLbmwFVt3rmOAeaCgyNqV4eXFSJFzMZjVAU astolfo@moegoofy" ];
    };
  };

  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  security = {
    pam.services.hyprlock.enable = true;

    # Enable memory safe Rust written sudo
    sudo.enable = false;
    sudo-rs = {
      enable = true;

      execWheelOnly = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      micro
      wget
      git
    ];

    wordlist.enable = true;
  };

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
  system.stateVersion = "26.05"; # Did you read the comment?
}
