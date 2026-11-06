{
  inputs,
  self,
  ...
}: let
  # Assume default username for WSL2
  username = "nixos";
in {
  flake.homeConfigurations.home = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      self.homeModules.shell
      self.homeModules.list
      self.homeModules.home
      {
        home = {
          username = "${username}";
          homeDirectory = "/home/${username}";
        };
        programs.home-manager.enable = true;
        targets.genericLinux.enable = true;
      }
    ];
  };
}
