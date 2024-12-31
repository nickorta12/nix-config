# Docs at https://gethomepage.dev/
{
  config,
  self,
  ...
}: {
  services.homepage-dashboard = {
    enable = true;
    environmentFile = config.sops.secrets.homepage.path;
  };
  # Holy indent Batman!
  services.homepage-dashboard.services = [
    {
      "Media" = [
        {
          "Jellyfin" = {
            description = "Jellyfin media server";
            href = "https://jellyfin.olivorta.com";
            icon = "jellyfin";
          };
        }
      ];
    }
    {
      "Feeds" = [
        {
          "FreshRSS" = {
            description = "Self hosted RSS feed manager";
            href = "https://freshrss.olivorta.com";
            icon = "freshrss";
            widget = {
              type = "freshrss";
              url = "https://freshrss.olivorta.com";
              username = "norta";
              password = "{{HOMEPAGE_VAR_FRESHRSS_PASSWORD}}";
            };
          };
        }
        {
          "ChangeDetection" = {
            description = "Detect changes in websites";
            href = "https://change.olivorta.com";
            icon = "changedetection-io";
            widget = {
              type = "changedetectionio";
              url = "https://change.olivorta.com";
              key = "{{HOMEPAGE_VAR_CHANGEDETECTION_API_KEY}}";
            };
          };
        }
      ];
    }
    {
      "Documents" = [
        {
          "Paperless" = {
            description = "Document management system for physical documents";
            href = "https://paperless.olivorta.com";
            icon = "paperless-ngx";
            widget = {
              type = "paperlessngx";
              url = "https://paperless.olivorta.com";
              key = "{{HOMEPAGE_VAR_PAPERLESS_API_KEY}}";
            };
          };
        }
      ];
    }
  ];

  sops.secrets.homepage = {
    format = "dotenv";
    sopsFile = "${self}/secrets/homepage.env";
  };

  services.nginx.virtualHosts."www.olivorta.com" = {
    useACMEHost = "olivorta.com";
    forceSSL = true;
    serverAliases = ["olivorta.com"];

    locations."/" = let
      port = builtins.toString config.services.homepage-dashboard.listenPort;
    in {
      proxyPass = "http://127.0.0.1:${port}";
    };
  };
}
