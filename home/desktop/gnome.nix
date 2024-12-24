{
  lib,
  pkgs,
  ...
}: let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    tray-icons-reloaded
    caffeine
    # solaar-extension
    search-light
    (disable-workspace-animation.override {
      version = "6";
      sha256 = "1m4bbhicfk5znnspldky1sapq0vfqrj8dzhyx5jgb882zhydiv9d";
      metadata = "ewogICJfZ2VuZXJhdGVkIjogIkdlbmVyYXRlZCBieSBTd2VldFRvb3RoLCBkbyBub3QgZWRpdCIsCiAgImRlc2NyaXB0aW9uIjogIkdOT01FIFNoZWxsIDQ1KyBleHRlbnNpb24gdGhhdCBkaXNhYmxlcyB0aGUgd29ya3NwYWNlIGFuaW1hdGlvbiB3aGVuIHN3aXRjaGluZyBiZXR3ZWVuIHdvcmtzcGFjZXMiLAogICJuYW1lIjogIkRpc2FibGUgV29ya3NwYWNlIEFuaW1hdGlvbiIsCiAgInNoZWxsLXZlcnNpb24iOiBbCiAgICAiNDUiLAogICAgIjQ2IiwKICAgICI0NyIKICBdLAogICJ1cmwiOiAiaHR0cHM6Ly9naXRodWIuY29tL2V0aG5hcnF1ZS9nbm9tZS1kaXNhYmxlLXdvcmtzcGFjZS1hbmltYXRpb24iLAogICJ1dWlkIjogImRpc2FibGUtd29ya3NwYWNlLWFuaW1hdGlvbkBldGhuYXJxdWUiLAogICJ2ZXJzaW9uIjogNgp9";
    })
  ];
  gnomeUuids = lib.map (x: x.extensionUuid) gnomeExtensions;
in {
  imports = [
    ./base.nix
  ];

  home.packages = with pkgs;
    [
      bitwarden
      obsidian
      wl-clipboard
    ]
    ++ gnomeExtensions;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = gnomeUuids;
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Control><Alt>1"];
      switch-to-workspace-2 = ["<Control><Alt>2"];
      switch-to-workspace-3 = ["<Control><Alt>3"];
      switch-to-workspace-4 = ["<Control><Alt>4"];
      switch-input-source = [];
      switch-input-source-backward = [];
      move-to-center = ["<Super>Home"];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "wezterm";
      binding = "<Super>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Toggle Caffeine";
      command = "toggle-caffeine";
      binding = "<Super>c";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["terminate:ctrl_alt_bksp" "caps:escape"];
    };
    "org/gnome/shell/extensions/search-light" = {
      shortcut-search = ["<Super>space"];
    };
  };
}
