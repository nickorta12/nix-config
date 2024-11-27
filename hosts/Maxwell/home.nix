{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
    "${self}/home/dev.nix"
    "${self}/home/dev-gui.nix"
  ];
  home.stateVersion = "24.05";
}
