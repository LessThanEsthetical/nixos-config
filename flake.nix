{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } ( inputs.import-tree ./modules );

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    stylix = {
      url = "github:nix-community/stylix";
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

    #hyprland = {
      #url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    #};

    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
