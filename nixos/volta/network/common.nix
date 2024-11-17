{
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
  };
  services.resolved = {
    domains = ["~."];
    extraConfig = ''
      DNSStubListener=false
    '';
  };
  networking = {
    nameservers = ["8.8.8.8" "8.8.4.4"];
    firewall = {
      enable = true;
    };
    useHostResolvConf = false;
  };
}
