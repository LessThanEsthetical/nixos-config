{ inputs, self, config, ... }:
{  
  flake.nixosConfigurations.main-pc = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    #specialArgs = { inherit inputs; };
    modules = [
    self.nixosModules.pc
    inputs.home-manager.nixosModules.home-manager
    self.nixosModules.settings
    { 
      home-manager = { 
        useGlobalPkgs = true;
	useUserPackages = true;
	extraSpecialArgs = { inherit inputs; };
	users."${config.settings.username}".imports = builtins.attrValues { inherit (self.homeModules) home shell list niri; };
      };
     }
    ];
  };
}
