{config, ...}: let
  domain = "change.olivorta.com";
  url = "https://${domain}";
in {
  services.changedetection-io = {
    enable = true;
    behindProxy = true;
    webDriverSupport = true;
    baseURL = url;
  };

  services.nginx.virtualHosts.${domain} = {
    useACMEHost = "olivorta.com";
    forceSSL = true;

    locations."/" = let
      port = builtins.toString config.services.changedetection-io.port;
    in {
      proxyPass = "http://127.0.0.1:${port}";
    };
  };
}
