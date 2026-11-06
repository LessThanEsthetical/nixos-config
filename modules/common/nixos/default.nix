{
  flake.nixosModules.default = {
    config,
    lib,
    pkgs,
    ...
  }: {
    hardware.facter.enable = true;
    console.font = "${pkgs.terminus_font}/share/consolefonts/ter-120b.psf.gz"; # I don't particularly enjoy Times New Roman-like bitmap font
    console.earlySetup = true;
    i18n.defaultLocale = "en_US.UTF-8";

    boot.loader.systemd-boot = {
      enable = true;

      editor = false;
      memtest86.enable = true;
      consoleMode = "max";
    };

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

      fwupd.enable = true;

      # I do really like Ly, but graphical-session.target and Waybar seems to be bugged with this
      # See: https://github.com/nix-community/home-manager/issues/8317
      #displayManager.ly = {
      #  enable = true;

      #  x11Support = false;
      #  settings = {
      #    battery_id = "BAT0";
      #    auth_fails = 5;
      #    bg = "0x001a1b26"; # Tokyo Night
      #    fg = "0x00a0bdd7";
      #    bigclock = "en";
      #    bigclock_seconds = true;
      #    blank_box = false;
      #    clear_password = true;
      #    full_color = true;
      #    shell = true;
      #    show_tty = true;
      #    text_in_center = true;
      #    show_password_key = "F7";
      #    shutdown_key = "F1";
      #    shutdown_cmd = "poweroff";
      #    restart_key = "F2";
      #    restart_cmd = "reboot";
      #    default_input = "password";
      #  };
      #};

      # In case of Lemurs, you can't "restart" Niri. You'll need to restart PC first + lacks shell login
      # See: https://github.com/coastalwhite/lemurs/issues/254
      # See: https://github.com/coastalwhite/lemurs/issues/225
      #displayManager.lemurs.enable = true;

      displayManager.enable = true;
      greetd = {
        enable = true;

        useTextGreeter = true;
        settings = {
          terminal.vt = 1;
          default_session = {
            command = "${lib.getExe pkgs.tuigreet} --time --battery --user ${config.users.users.defaultUser.name} --remember --remember-user-session --asterisks";
          };
        };
      };
    };

    # Shamelessly copied: https://github.com/sjcobb2022/nixos-config/raw/refs/heads/main/hosts/common/optional/greetd.nix
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    programs.less = {
      enable = true;

      # Weird bug that without -R flag, less pager will output ANSI escape codes
      # See: https://github.com/NixOS/nix/issues/8779
      envVariables.LESS = "-R --quiet";
    };

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Warsaw";

    users.defaultUserShell = pkgs.bash;

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
