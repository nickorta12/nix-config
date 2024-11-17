{pkgs, ...}: let
  stevenBlack = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
in {
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
}
