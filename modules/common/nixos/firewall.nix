{
  flake.nixosModules.firewall = {
    networking = {
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
