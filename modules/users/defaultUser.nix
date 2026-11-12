{inputs, ...}: let
  # Change username here
  username = "yuuki";
in {
  flake.nixosModules.defaultUser = {pkgs, ...}: {
    imports = [inputs.home-manager.nixosModules.home-manager inputs.niri.nixosModules.niri];

    programs = {
      zsh.enable = true;
      niri = {
        enable = true;
        package = pkgs.niri;
      };
    };

    users.users.defaultUser = {
      enable = true;

      name = "${username}";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ["wheel" "networkmanager"];
      hashedPassword = "$y$j9T$L5PIksAB7wo3y62iuk5c7.$Q6h4UDCPMYNdsbfmkCdulR6iQP69NdEZNcJ.AqWAxU1"; # A temporarily set up password
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      backupFileExtension = "bak";

      users.defaultUser = {
        imports = builtins.attrValues {inherit (inputs.self.homeModules) home niriwm shell list waybar media;};
        home = {
          homeDirectory = "/home/${username}";
          username = "${username}";
        };
      };
    };
  };
}
