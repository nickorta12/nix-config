{
  services = {
    tailscale.enable = true;

    dnsmasq = {
      enable = true;
      resolveLocalQueries = false;
      settings = {
        listen-address = [
          "127.0.0.1"
          "10.25.0.2"
        ];
        domain = "olivorta.com";
        expand-hosts = true;
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
