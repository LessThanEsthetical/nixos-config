{
  inputs,
  self,
  ...
}: let
  # Change hostname here and use for building (nixos-rebuild switch --flake .#<hostname>)
  hostname = "vm";
in {
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.vm
      self.nixosModules.yuuki
      {networking.hostName = "${hostname}";}
      self.diskoConfigurations.diskovm
    ];
  };
}
