{pkgs, ...}: {
  imports = [
    ../common/packages.nix
    ../common/nixos
    ./hardware-configuration.nix
    ./network
    ./caddy.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };

    # Media
    jellyfin = {
      enable = true;
    };

    # Shell history
    atuin = {
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
      openRegistration = true;
    };

    # Cleanup
    logrotate = {
      enable = true;
      settings = {
        "/var/log/blocky/*.log" = {
          frequency = "daily";
        };
      };
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."jellyfin.olivorta.com" = {
        useACMEHost = "olivorta.com";
        forceSSL = true;
        extraConfig = ''
          client_max_body_size 20M;
        '';

        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          extraConfig = ''
            proxy_buffering off;
          '';
        };
        locations."/socket" = {
          proxyPass = "http://127.0.0.1:8096";
          proxyWebsockets = true;
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "nickorta12@gmail.com";
    certs = {
      "olivorta.com" = {
        domain = "*.olivorta.com";
        group = "nginx";
        dnsProvider = "cloudflare";
        environmentFile = "/var/lib/cloudflare.txt";
      };
    };
  };

  virtualisation = {
    docker.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tcpdump
  ];

  system.stateVersion = "24.05";
}
