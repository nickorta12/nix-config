{...}: {
  imports = [
    ./config.nix
    ./keys.nix
    ./plugins
  ];

  performance.byteCompileLua.enable = true;

  files = let
    indent = num: {
      opts = {
        tabstop = num;
        softtabstop = num;
        shiftwidth = num;
      };
    };
  in {
    "ftplugin/lua.lua" = indent 2;
    "ftplugin/nix.lua" = indent 2;
    "ftplugin/yaml.lua" = indent 2;
    "ftplugin/markdown.lua" = {
      opts.textwidth = 100;
    };
  };
}
