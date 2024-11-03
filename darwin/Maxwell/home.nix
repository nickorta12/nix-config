{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
  ];
  home.stateVersion = "24.05";
}
