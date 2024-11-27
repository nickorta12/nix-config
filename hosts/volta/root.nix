{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
  ];
  home.username = "root";
  home.homeDirectory = "/root";

  home.stateVersion = "24.05";
}
