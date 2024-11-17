let
  stevenBlack = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
in {
  containers.blocky = let
    ip = "10.25.0.3";
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
          allowedTCPPorts = [53 4000];
          allowedUDPPorts = [53];
        };
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
