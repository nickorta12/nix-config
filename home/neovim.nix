{
  inputs,
  system,
  ...
}: {
  home = {
    packages = [
      inputs.nickvim.packages.${system}.default
    ];
    sessionVariables.EDITOR = "nvim";
    shellAliases.vimdiff = "nvim -d";
  };
}
