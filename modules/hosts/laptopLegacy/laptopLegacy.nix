# Used for old Sony VAIO laptop as configuration testing
{
  inputs,
  self,
  ...
}: let
  # Change hostname here and use for building (nixos-rebuild switch --flake .#<hostname>)
  hostname = "legacyLaptop";
in {
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.laptopLegacy
      self.nixosModules.defaultUser
      {networking.hostName = "${hostname}";}
      self.diskoConfigurations.diskoLaptopLegacy
    ];
  };
}
