{ self, inputs, ... }:

{
  flake.nixosConfigurations.main-pc = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ self.nixosModules.conf inputs.home-manager.nixosModules.home-manager 
    {
      home-manager = { 
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.furina = self.homeModules.hm;
      };
    }
    ];
  };
}
