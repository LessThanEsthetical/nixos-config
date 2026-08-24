{ inputs, ... }:
let
  # Change username here
  username = "yuuki";
in
{
  flake.nixosModules.user = { self, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users."${username}" = {
      enable = true;

      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      hashedPassword = "$y$j9T$L5PIksAB7wo3y62iuk5c7.$Q6h4UDCPMYNdsbfmkCdulR6iQP69NdEZNcJ.AqWAxU1"; # A temporary set up password
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2Ld4FLFrLbmwFVt3rmOAeaCgyNqV4eXFSJFzMZjVAU astolfo@moegoofy" ];
    };

    home-manager = { 
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      backupFileExtension = "bak";

      users."${username}" = {
	imports = builtins.attrValues { inherit (inputs.self.homeModules) home shell list niriwm waybar; };
        home = {
          homeDirectory = "/home/${username}";
	  username = "${username}";
	};
      };
    };
  };
}
