{pkgs, ...}: {
  imports = [
    ../common/packages.nix
    ../common/sops.nix
    ../common/nixos
    ./hardware-configuration.nix
    ./network
    ./services
    ./caddy.nix
  ];

  sops.defaultSopsFile = ../../secrets/volta.yaml;

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
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "nickorta12@gmail.com";
    certs = {
      "olivorta.com" = {
        domain = "*.olivorta.com";
        extraDomainNames = [
          "olivorta.com"
        ];

        group = "nginx";
        dnsProvider = "cloudflare";
        environmentFile = "/var/lib/cloudflare.txt";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tcpdump
  ];

  system.stateVersion = "24.05";
}
