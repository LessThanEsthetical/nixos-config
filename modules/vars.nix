{
flake.nixosModules.settings = { config, lib, ... }: {

  options.settings = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "LessThanEsthetical";
      description = "Sets a username for normal account user on machine";
    };
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "host";
      description = "Sets a hostname";
    };
    ssh-keys = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [ ];
      description = "Adds public SSH keys for access";
    };
    timezone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Warsaw";
      description = "Sets a timezone";
    };
  };
  };
}
