{...}: let
  ip = "10.25.0.2";
in {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };

  networking = {
    useDHCP = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [53 4000];
      allowedUDPPorts = [53 67];
    };
    nat = {
      enable = true;
      internalInterfaces = ["ve-blocky"];
      externalInterface = "eno4";
    };
  };

  systemd.network = {
    enable = true;
    networks."10-eno4" = {
      matchConfig.Name = "eno4";
      address = [
        "${ip}/24"
      ];
      gateway = [
        "10.25.0.1"
      ];
      dns = [
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };

  services = {
    tailscale.enable = true;

    dnsmasq = {
      enable = true;
      resolveLocalQueries = false;
      settings = {
        listen-address = [
          "127.0.0.1"
          "10.25.0.2"
        ];
        domain = "olivorta.com";
        expand-hosts = true;
        no-resolv = true;
        server = ["192.168.100.11"];
        dhcp-range = "10.25.0.10,10.25.0.200,12h";
        dhcp-option = "3,10.25.0.1";
        local-service = true;
        bogus-priv = true;
        domain-needed = true;
      };
    };
  };
}
