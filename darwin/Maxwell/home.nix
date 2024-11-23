{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
    "${self}/home/dev.nix"
  ];
  home.stateVersion = "24.05";
}
