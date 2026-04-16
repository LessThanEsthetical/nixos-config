{
  description = "Config for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #arkenfox = {
      #url = "github:dwarfmaster/arkenfox-nixos/main";
      #inputs.nixpkgs.follows = "nixpkgs";
    #};
    # Figure out later to enable user.js
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  # Later add other entries, this one is for PC for now
  outputs = inputs@{ self, nixpkgs, niri, hyprland, home-manager, ... }: { 
    # Add niri when it'll be possible
    nixosConfigurations.main-pc = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
        modules = [
	  ./main-pc/configuration.nix
	  #./common/niri.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.furina.imports = [ ./main-pc/home.nix ./common/misc.nix ];
	  }
	];   
    };
  };
}

