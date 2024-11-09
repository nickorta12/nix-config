{...}: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };
  systemd.network = {
    enable = true;
    networks."10-eno4" = {
      matchConfig.Name = "eno4";
      address = [
        "10.25.0.2/24"
        "192.168.0.78/24"
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
}
