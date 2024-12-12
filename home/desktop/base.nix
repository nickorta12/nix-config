{
  inputs,
  pkgs,
  isLinux,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden
    obsidian
  ];

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          raindropio
          ublock-origin
          vimium
        ];
        search = {
          force = true;
          default = "Kagi";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                  ];
                }
              ];
              definedAliases = ["@nix-packages"];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                  ];
                }
              ];
              definedAliases = ["@nix-options"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
              definedAliases = ["@home-options"];
            };
            "Kagi" = {
              urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
              definedAliases = ["@kagi"];
            };
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "DuckDuckGo".metaData.hidden = true;
          };
          order = [
            "Kagi"
            "Google"
            "Nix Packages"
            "Nix Options"
            "Home Manager Options"
          ];
        };
        settings = {
          "browser.tabs.closeWindowWithLastTab" = !isLinux;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        };
      };
    };
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
  };
}
