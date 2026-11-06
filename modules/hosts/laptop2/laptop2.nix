# This is used for ASUS Laptop
{
  inputs,
  self,
  ...
}: let
  # Change hostname here and use for building (nixos-rebuild switch --flake .#<hostname>)
  hostname = "laptop2";
in {
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.laptop2
      self.nixosModules.defaultUser
      {networking.hostName = "${hostname}";}
      self.diskoConfigurations.diskolaptop2
    ];
  };
}
