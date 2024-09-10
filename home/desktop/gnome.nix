{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./base.nix
  ];

  home.packages = with pkgs.gnomeExtensions;
    [
      blur-my-shell
      tray-icons-reloaded
      caffeine
      solaar-extension
    ]
    ++ (with pkgs; [
      bitwarden
      obsidian
    ]);

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
        "solaar-extension@sidevesh"
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
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
  };
}
