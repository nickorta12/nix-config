{self, ...}: {
  imports = [
    "${self}/home/desktop/gnome.nix"
    "${self}/home/shell"
    "${self}/home/wezterm"
    "${self}/home/neovim.nix"
  ];
  home.username = "norta";
  home.homeDirectory = "/home/norta";

  home.stateVersion = "23.11";
}
