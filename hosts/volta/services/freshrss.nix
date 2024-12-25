{config, ...}: let
  domain = "freshrss.olivorta.com";
  url = "https://${domain}";
in {
  services.freshrss = {
    enable = true;
    defaultUser = "norta";
    passwordFile = config.sops.secrets.freshrss-password.path;
    virtualHost = domain;
    baseUrl = url;
  };

  services.nginx.virtualHosts.${domain} = {
    useACMEHost = "olivorta.com";
    forceSSL = true;
  };

  sops.secrets.freshrss-password = {
    owner = config.services.freshrss.user;
  };
}
