{...}: let
  ip = "10.25.0.2";
  dns = [
    "8.8.8.8"
    "8.8.4.4"
  ];
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
      dns = dns;
    };
  };

  containers.blocky = {
    privateNetwork = true;
    autoStart = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    config = {lib, ...}: {
      system.stateVersion = "24.05";
      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [53 4000];
          allowedUDPPorts = [53];
        };
        useHostResolvConf = lib.mkForce false;
      };
      systemd.services.blocky.serviceConfig = {
        LogsDirectory = "blocky";
      };
      services.blocky = {
        enable = true;
        settings = {
          upstreams.groups.default = dns;
          bootstrapDns = [
            {upstream = "8.8.8.8";}
            {upstream = "8.8.4.4";}
          ];
          ports = {
            dns = 53;
            http = 4000;
          };
          blocking = {
            loading = {
              refreshPeriod = "24h";
              downloads.timeout = "30s";
            };
            denylists = {
              StevenBlack = [
                "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
              ];
            };
            allowlists = {
              StevenBlack = [
                "${./allow-list.txt}"
              ];
            };
            clientGroupsBlock = {
              default = [
                "StevenBlack"
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
    };
  };

  services = {
    tailscale.enable = true;

    # kea.dhcp4 = {
    #   enable = true;
    #   settings = {
    #     interfaces-config = {
    #       interfaces = ["eno4"];
    #     };
    #     lease-database = {
    #       name = "/var/lib/kea/dhcp4.leases";
    #       persist = true;
    #       type = "memfile";
    #       lfc-interval = 1000;
    #       max-row-errors = 100;
    #     };
    #     rebind-timer = 2000;
    #     renew-timer = 1000;
    #     valid-lifetime = 4000;
    #     option-data = [
    #       {
    #         name = "routers";
    #         data = "10.25.0.1";
    #       }
    #       {
    #         name = "domain-name-servers";
    #         data = "${ip}";
    #       }
    #     ];
    #     subnet4 = [
    #       {
    #         id = 1;
    #         subnet = "10.25.0.0/24";
    #         pools = [
    #           {
    #             pool = "10.25.0.10 - 10.25.0.200";
    #           }
    #         ];
    #       }
    #     ];
    #   };
    # };

    dnsmasq = {
      enable = true;
      resolveLocalQueries = false;
      settings = {
        listen-address = [
          "127.0.0.1"
          "10.25.0.2"
        ];
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
