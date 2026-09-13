{lib, ...}: {
  options.flake = {
    homeModules = lib.mkOption {
      default = {};
      type = lib.types.lazyAttrsOf lib.types.raw;
      description = "Flake-parts homeModules in set";
    };
    diskoConfigurations = lib.mkOption {
      default = {};
      type = lib.types.attrsOf lib.types.deferredModule;
      description = "Flake-parts unique modules of diskoConfigurations";
    };
  };
}
# See:
# https://www.answeroverflow.com/m/1474411469478297944
# https://github.com/denful/den/discussions/317

