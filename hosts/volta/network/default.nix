{pkgs, ...}: let
  ip = "10.25.0.2";
in {
  imports = [
    ./blocky.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };

  networking = {
    useDHCP = false;
    nameservers = ["8.8.8.8" "8.8.4.4"];
    firewall = {
      enable = true;
      allowedTCPPorts = [53];
      allowedUDPPorts = [53 67];
    };
  };

  systemd = {
    network = {
      enable = true;
      wait-online.enable = false;
      netdevs."10-br0" = {
        netdevConfig = {
          Name = "br0";
          Kind = "bridge";
        };
      };
      networks = {
        "11-br0-en" = {
          name = "eno*";
          bridge = ["br0"];
        };
        "11-br0" = {
          name = "br0";
          address = [
            "${ip}/24"
          ];
          gateway = [
            "10.25.0.1"
          ];
        };
      };
    };
  };

  services = {
    tailscale.enable = true;

    resolved = {
      domains = ["~."];
      extraConfig = ''
        DNSStubListener=false
      '';
    };

    dnsmasq = {
      enable = true;
      resolveLocalQueries = false;
      settings = {
        listen-address = [
          "10.25.0.2"
        ];
        domain = "olivorta.com";
        expand-hosts = true;
        dhcp-host = "02:03:ea:84:fb:95,nick-phone";
        dhcp-range = "10.25.0.10,10.25.0.200,12h";
        dhcp-option = [
          "3,10.25.0.1" # Modem is the gateway
          "6,10.25.0.3" # Use blocky as the DNS router in the subnet
        ];
        no-hosts = true;
        addn-hosts = toString (pkgs.writeText "addn-hosts.txt" ''
          10.25.0.1   router modem
          10.25.0.2   volta
          10.25.0.3   blocky
        '');
        local-service = true;
        bogus-priv = true;
        domain-needed = true;
      };
    };
  };
}
