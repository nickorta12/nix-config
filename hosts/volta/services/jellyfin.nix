{
  # Media
  services.jellyfin = {
    enable = true;
  };

  services.nginx.virtualHosts."jellyfin.olivorta.com" = {
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
}
