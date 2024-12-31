{
  config,
  inputs,
  ...
}: let
  ip = "10.25.0.4";
  ipNet = "${ip}/24";
  router = "10.25.0.1";
  volta = "10.25.0.2";
  blocky = "10.25.0.3";
in {
  containers.nix-router = {
    autoStart = true;
    hostBridge = "br0";
    privateNetwork = true;
    localAddress = ipNet;
    bindMounts."/var/lib/private/sops/age/keys.txt" = {};

    config = {
      config,
      pkgs,
      ...
    }: {
      imports = [
        inputs.sops-nix.nixosModules.sops
        ../../common/sops.nix
      ];
      system.stateVersion = "24.05";
      sops = {
        defaultSopsFile = ../../../secrets/volta.yaml;
        secrets.mac-addresses = {
          owner = "dnsmasq";
        };
      };

      systemd = {
        network = {
          enable = true;
          wait-online.enable = false;
          networks."10-default" = {
            matchConfig.Name = "eth0";
            gateway = [
              router
            ];
          };
        };
      };

      networking = {
        nameservers = ["8.8.8.8" "8.8.4.4"];
        firewall = {
          enable = true;
          allowedTCPPorts = [53];
          allowedUDPPorts = [53 67];
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
        dnsmasq = {
          enable = true;
          resolveLocalQueries = false;
          settings = {
            listen-address = [
              ip
            ];
            address = "/olivorta.com/${volta}";
            domain = "olivorta.com";
            expand-hosts = true;
            conf-file = config.sops.secrets.mac-addresses.path;
            dhcp-range = "10.25.0.10,10.25.0.220,12h";
            dhcp-option = [
              "3,${router}" # Modem is the gateway
              "6,${blocky}" # Use blocky as the DNS router in the subnet
            ];
            no-hosts = true;
            addn-hosts = toString (pkgs.writeText "addn-hosts.txt" ''
              ${router}   router modem
              ${volta}   volta
              ${blocky}   blocky
            '');
            local-service = true;
            bogus-priv = true;
            domain-needed = true;
          };
        };
      };
    };
  };
}
