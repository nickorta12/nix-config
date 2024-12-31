let
  stevenBlack = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
  ip = "10.25.0.3";
  ipNet = "${ip}/24";
  dnsmasq = "10.25.0.4";
in {
  containers.blocky = {
    autoStart = true;
    hostBridge = "br0";
    privateNetwork = true;
    localAddress = ipNet;

    config = {pkgs, ...}: {
      system.stateVersion = "24.05";

      systemd = {
        network = {
          enable = true;
          wait-online.enable = false;
          networks."10-default" = {
            matchConfig.Name = "eth0";
            gateway = [
              "10.25.0.1"
            ];
          };
        };
        services.blocky.serviceConfig = {
          LogsDirectory = "blocky";
        };
      };

      networking = {
        nameservers = ["8.8.8.8" "8.8.4.4"];
        firewall = {
          enable = true;
          allowedTCPPorts = [53 4000];
          allowedUDPPorts = [53];
        };
        useHostResolvConf = false;
      };

      services = {
        resolved = {
          domains = ["~."];
          extraConfig = ''
            DNSStubListener=false
          '';
        };
        blocky = {
          enable = true;
          settings = {
            upstreams.groups.default = [
              "8.8.8.8"
              "8.8.4.4"
            ];
            bootstrapDns = [
              {upstream = "8.8.8.8";}
              {upstream = "8.8.4.4";}
            ];
            ports = {
              dns = 53;
              http = 4000;
            };
            conditional.mapping = {
              "olivorta.com" = dnsmasq;
              "0.25.10.in-addr.arpa" = dnsmasq;
              "." = dnsmasq;
            };
            blocking = {
              loading = {
                refreshPeriod = "24h";
                downloads.timeout = "30s";
              };
              denylists = {
                StevenBlack = [
                  stevenBlack
                ];
              };
              allowlists = {
                StevenBlack = [
                  "${pkgs.writeText "allow-lists.txt" "s.youtube.com"}"
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
  };
}
