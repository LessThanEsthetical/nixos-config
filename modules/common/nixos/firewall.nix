{
  flake.nixosModules.firewall = {
    networking = {
      iproute2.enable = true;
      firewall = {
        enable = true;

        backend = "nftables";
        filterForward = true;
      };
      nftables = {
        enable = true;

        flushRuleset = true;
      };
    };
  };
}
