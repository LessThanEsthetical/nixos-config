{ lib, ... }:

{
  options.flake.homeModules = lib.mkOption {
    default = {};
    type = lib.types.lazyAttrsOf lib.types.raw;
  };
}
