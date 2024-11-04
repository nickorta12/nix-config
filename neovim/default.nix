{...}: {
  imports = [
    ./config.nix
    ./keys.nix
    ./plugins
  ];

  performance.byteCompileLua.enable = true;

  files = let
    indent = num: {
      localOpts = {
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

  autoCmd = [
    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Close Telescope prompt in insert mode by clicking escape
    {
      event = ["FileType"];
      pattern = "TelescopePrompt";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    }
  ];
}
