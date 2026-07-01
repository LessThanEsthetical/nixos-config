{ self, ... }:

{
  flake.homeModules.niri = {
    imports = with self.homeModules; [ waybar niriwm ];
  };
}
