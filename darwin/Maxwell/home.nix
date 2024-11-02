{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim"
  ];
  home.stateVersion = "24.05";
}
