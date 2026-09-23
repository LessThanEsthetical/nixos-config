{
  flake.homeModules.list = {pkgs, ...}: {
    home.packages = builtins.attrValues {
      inherit
        (pkgs)
        # Tape archiving
        zip
        xz
        gnutar
        # Working with files
        less
        bat
        yazi
        fzf
        eza
        tree
        fd
        devenv
        # Working with text
        ripgrep
        gnused
        gawk
        # Web utilites
        curl
        wget
        aria2
        rsync
        # Network utilites
        iproute2
        dnsutils
        socat
        nmap
        # System utilites
        btop
        file
        gnupg
        fastfetch
        lsof
        pciutils
        usbutils
        coreutils
        comma
        ;
    };
  };
}
