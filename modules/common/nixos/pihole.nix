{
  flake.nixosModules.pihole = {
    services = {
      pihole-ftl = {
        enable = true;

        openFirewallDHCP = true;
        openFirewallWebserver = true;
        settings = {
          dns.upstreams = ["127.0.0.1#5335" "::1#5335"];
          dhcp = {
            active = true;
            start = "192.168.2.0";
            end = "192.168.2.255";
            router = "192.168.8.1";
            ipv6 = true;
          };
          misc.readOnly = true;
          webserver.interface.theme = "default-darker";
          webserver.api.prettyJSON = true;
        };
      };
      pihole-web = {
        enable = true;

        ports = ["80r" "443s"];
      };
    };
    networking.firewall.allowedTCPPorts = [80 443];
  };
}
