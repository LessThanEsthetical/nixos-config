{
  inputs,
  self,
  lib,
  ...
}: let
  username = "astolfo";
in {
  flake.homeConfigurations.home = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      self.homeModules.shell
      self.homeModules.list
      self.homeModules.niriwm
      self.homeModules.home
      {
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        programs.home-manager.enable = true;
        programs.kitty.enable = lib.mkForce false;
        targets.genericLinux.enable = true;
      }
    ];
  };
}
