{...}: let
  ip = "10.25.0.2";
in {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv4.conf.all.forwarding" = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [53];
    allowedUDPPorts = [53 67];
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
        "4.4.4.4"
      ];
    };
  };
  services = {
    tailscale.enable = true;

    # DNS blocking
    blocky = {
      enable = true;
      settings = {
        upstreams.groups.default = [
          "8.8.8.8"
          "8.8.4.4"
        ];
        ports.dns = "${ip}:53";
        blocking = {
          loading.refreshPeriod = "72h";
          denylists = {
            main = [
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
            ];
          };
          clientGroupsBlock = {
            default = [
              "main"
            ];
          };
        };
        queryLog = {
          type = "csv-client";
          target = "/var/log/blocky";
          logRetentionDays = 5;
        };
      };
    };

    kea.dhcp4 = {
      enable = true;
      settings = {
        interfaces-config = {
          interfaces = ["eno4"];
        };
        lease-database = {
          name = "/var/lib/kea/dhcp4.leases";
          persist = true;
          type = "memfile";
          lfc-interval = 1000;
          max-row-errors = 100;
        };
        rebind-timer = 2000;
        renew-timer = 1000;
        valid-lifetime = 4000;
        option-data = [
          {
            name = "routers";
            data = "10.25.0.1";
          }
          {
            name = "domain-name-servers";
            data = "${ip}";
          }
        ];
        subnet4 = [
          {
            id = 1;
            subnet = "10.25.0.0/24";
            pools = [
              {
                pool = "10.25.0.10 - 10.25.0.200";
              }
            ];
          }
        ];
      };
    };
  };

  systemd.services.blocky.serviceConfig = {
    LogsDirectory = "blocky";
  };
}
