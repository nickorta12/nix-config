{pkgs, ...}: let
  ip = "10.25.0.2";
in {
  imports = [
    ./blocky.nix
    ./nix-router.nix
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
  };
}
