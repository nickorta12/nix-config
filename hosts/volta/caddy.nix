{
  services.caddy = {
    enable = false;
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
