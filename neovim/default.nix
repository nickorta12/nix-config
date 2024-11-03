{...}: {
  imports = [
    ./config.nix
    ./plugins.nix
  ];

  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  performance.byteCompileLua.enable = true;
}
