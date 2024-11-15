{lib, ...}: {
  imports = [
    ./config.nix
    ./keys.nix
    ./plugins
  ];

  performance.byteCompileLua = {
    enable = true;
    nvimRuntime = true;
    configs = true;
    plugins = false;
  };

  colorschemes = lib.mkDefault {
    tokyonight = {
      enable = true;
      settings.style = "night";
    };
  };

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
    "ftplugin/alpha" = {
      localOpts.buflisted = false;
    };
    "ftplugin/help.vim" = {
      extraConfigVim = ''
        wincmd T
      '';
    };
  };

  autoCmd = [
    {
      event = ["FileType"];
      pattern = "TelescopePrompt";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
    }
  ];
}
