{
  inputs,
  config,
  self,
  ...
}: let
  username = config.users.users.defaultUser.name;
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
