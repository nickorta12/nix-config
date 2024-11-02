{...}: {
  imports = [
    ./config.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    performance.byteCompileLua.enable = true;
  };
}
