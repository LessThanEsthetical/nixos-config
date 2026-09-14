let
  username = "john";
in {
  flake.nixosModules."${username}" = {
    # This account is used by everyone else, no sudo rights (user isn't included into wheel group), uses KDE Plasma by default for Windows-like experience and Bash
    # To login, use 1234 password

    users.users."${username}" = {
      enable = true;

      isNormalUser = true;
      password = "1234";
      extraGroups = ["seat"];
    };

    services.desktopManager.plasma6.enable = true;
  };
}
