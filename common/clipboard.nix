{ pkgs, lib, ... }:

{
  services.cliphist = {
    enable = true;
    clipboardPackage = [ pkgs.wl-clipboard-rs ];

    allowImages = true;
  };
}
