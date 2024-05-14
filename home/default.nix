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
    caffeine
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
        "caffeine@patapon.info"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Control><Alt>1"];
      switch-to-workspace-2 = ["<Control><Alt>2"];
      switch-to-workspace-3 = ["<Control><Alt>3"];
      switch-to-workspace-4 = ["<Control><Alt>4"];
      switch-input-source = [];
      switch-input-source-backward = [];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "wezterm";
      binding = "<Super>t";
    };
  };
}
