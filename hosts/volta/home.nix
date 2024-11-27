{self, ...}: {
  imports = [
    "${self}/home/shell"
    "${self}/home/neovim.nix"
  ];
  home.username = "norta";
  home.homeDirectory = "/home/norta";

  home.stateVersion = "24.05";
}
