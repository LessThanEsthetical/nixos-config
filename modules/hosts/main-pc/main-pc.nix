{ inputs, self, ... }:
let
  # Change hostname here and use for building (nixos-rebuild switch --flake .#<hostname>)
  hostname = "main-pc";
in
{
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.pc
      self.nixosModules.user
      { networking.hostName = "${hostname}"; }
      self.diskoConfigurations.diskopc
    ];
  };
}
