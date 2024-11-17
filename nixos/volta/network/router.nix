{
  services = {
    tailscale.enable = true;
  };

  containers.dnsmasq = let
    ip = "10.25.0.4";
    ipNet = "${ip}/24";
  in {
    autoStart = true;
    hostBridge = "br0";
    privateNetwork = true;
    localAddress = ipNet;

    config = {pkgs, ...}: {
      imports = [./common.nix];

      networking = {
        firewall = {
          allowedTCPPorts = [53];
          allowedUDPPorts = [53 67];
        };
      };

      services.dnsmasq = {
        enable = true;
        resolveLocalQueries = false;
        settings = {
          listen-address = [
            ip
          ];
          domain = "olivorta.com";
          expand-hosts = true;
          dhcp-host = "02:03:ea:84:fb:95,nick-phone";
          dhcp-range = "10.25.0.10,10.25.0.200,12h";
          dhcp-option = [
            "3,10.25.0.1" # Modem is the gateway
            "6,10.25.0.3" # Use blocky as the DNS router in the subnet
          ];
          addn-hosts = toString (pkgs.writeText "addn-hosts.txt" ''
            10.25.0.1   router modem
            10.25.0.2   volta
            10.25.0.3   blocky
            10.25.0.4   dnsmasq
          '');
          local-service = true;
          bogus-priv = true;
          domain-needed = true;
        };
      };
    };
  };
}
