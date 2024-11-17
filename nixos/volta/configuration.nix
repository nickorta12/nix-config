{pkgs, ...}: {
  imports = [
    ../common/common.nix
    ./hardware-configuration.nix
    ./network.nix
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
  };

  virtualisation = {
    docker.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tcpdump
  ];

  system.stateVersion = "24.05";
}
