{
  flake.nixosModules.unbound = {
    services.unbound = {
      enable = true;

      settings = {
        server = {
          # Settings according to Pi-Hole's Unbound doc: https://docs.pi-hole.net/guides/dns/unbound
          verbosity = 0;

          interface = ["127.0.0.1" "::1"];
          port = 5335;
          do-ip4 = true;
          do-ip6 = true;
          do-udp = true;
          do-tcp = true;
          prefer-ip6 = false;
          harden-glue = true;
          harden-dnssec-stripped = true;
          use-caps-for-id = false;
          edns-buffer-size = 1232;
          prefetch = true;
          num-threads = 1;
          so-rcvbuf = "1m";
          private-address = [
            "192.168.0.0/16"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "10.0.0.0/8"
            "fd00::/8"
            "fe80::/10"

            "192.0.2.0/24"
            "198.51.100.0/24"
            "203.0.113.0/24"
            "255.255.255.255/32"
            "2001:db8::/32"
          ];
        };

        # Specific settings
        forward-zone = {
          name = ".";
          forward-addr = ["9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9"]; #Quad9 DNS server
        };
      };
    };
  };
}
