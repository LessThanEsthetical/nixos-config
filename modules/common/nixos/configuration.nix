{
  flake.nixosModules.configuration = {pkgs, ...}: {
    hardware.facter.enable = true;

    nix = {
      package = pkgs.lixPackageSets.latest.lix;
      optimise.automatic = true;

      settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        use-xdg-base-directories = true;
      };
    };

    services = {
      openssh = {
        enable = true;

        ports = [3620];
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
        };
      };
    };

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Warsaw";

    programs.zsh.enable = true;

    security = {
      # Enable memory safe Rust written sudo
      sudo-rs = {
        enable = true;

        execWheelOnly = true;
      };
    };

    environment = {
      systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          neovim
          micro
          wget
          git
          ;
      };

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
    system.stateVersion = "26.05"; # Did you read the comment? (Yes, I did.)
  };
}
