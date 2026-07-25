{ inputs, self, config, pkgs, ... }:
let
  hostname = "main-pc";
  username = "yuuki";
in
{
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
    self.nixosModules.pc
    self.nixosModules.configuration
    inputs.disko.nixosModules.disko
    #self.diskoConfigurations.diskopc
    inputs.home-manager.nixosModules.home-manager
    { 
      home-manager = { 
        useGlobalPkgs = true;
	useUserPackages = true;
	extraSpecialArgs = { inherit inputs; };
	backupFileExtension = "bak";
        users."${username}".imports = builtins.attrValues { inherit (inputs.self.homeModules) home shell list niriwm waybar; };
      };
    }
    {
      networking.hostName = "${hostname}";
      users.users."${username}" = {
        enable = true;

        isNormalUser = true;
	extraGroups = [ "wheel" "networkmanager" ];
	hashedPassword = "$y$j9T$L5PIksAB7wo3y62iuk5c7.$Q6h4UDCPMYNdsbfmkCdulR6iQP69NdEZNcJ.AqWAxU1";
	openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2Ld4FLFrLbmwFVt3rmOAeaCgyNqV4eXFSJFzMZjVAU astolfo@moegoofy" ];
      };
    }
    ];
  };
}
