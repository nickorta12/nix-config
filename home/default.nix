{
  inputs,
  pkgs,
  lib,
  ...
}: {
  home.username = "norta";
  home.homeDirectory = "/home/norta";

  imports = [
    ./git.nix
    ./gui.nix
    ./nvim.nix
    ./shell.nix
    ./wezterm
    ./zsh.nix
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
      };
    };
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    tray-icons-reloaded
  ];

  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "trayIconsReloaded@selfmade.pl"
      ];
    };
  };
}
