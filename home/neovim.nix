{
  self,
  system,
  ...
}: {
  home = {
    packages = [
      self.packages.${system}.neovim
    ];
    sessionVariables.EDITOR = "nvim";
    shellAliases.vimdiff = "nvim -d";
  };
}
