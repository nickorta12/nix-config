{config, ...}: let
  domain = "paperless.olivorta.com";
  url = "https://${domain}";
in {
  services.paperless = {
    enable = true;
    database.createLocally = true;
    consumptionDirIsPublic = true;
    passwordFile = config.sops.secrets.paperless-password.path;
    settings = {
      PAPERLESS_URL = url;
      PAPERLESS_USE_X_FORWARD_HOST = true;
      PAPERLESS_USE_X_FORWARD_PORT = true;
    };
  };

  services.nginx.virtualHosts.${domain} = {
    useACMEHost = "olivorta.com";
    forceSSL = true;

    locations."/" = let
      port = builtins.toString config.services.paperless.port;
    in {
      proxyPass = "http://127.0.0.1:${port}";
      proxyWebsockets = true;
    };
  };

  sops.secrets.paperless-password = {
    owner = config.services.paperless.user;
  };
}
