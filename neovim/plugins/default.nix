{...}: {
  imports = [
    ./telescope.nix
    ./git.nix
  ];

  plugins = {
    which-key.enable = true;
  };
}
