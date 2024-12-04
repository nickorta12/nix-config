{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
    "${self}/home/dev.nix"
    "${self}/home/dev-gui.nix"
    "${self}/home/wezterm"
  ];
  home.stateVersion = "24.05";
}
