{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    #arkenfox= {
      #enable = true;
      #version = "140.0";
    #};
    nativeMessagingHosts = with pkgs; [ ff2mpv-rust tridactyl-native ];
    profiles.furina = {
      name = "furina";
      id = 0;
      isDefault = true;
      search.default = "ddg";
    };
  };
}
