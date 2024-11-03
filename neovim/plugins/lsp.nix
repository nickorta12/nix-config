{...}: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
        };
        pyright.enable = true;
      };
    };

    lspkind.enable = true;
    lsp-status.enable = true;
    conform-nvim.enable = true;
    rustaceanvim.enable = true;

    luasnip.enable = true;
    cmp_luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-look.enable = true;
    cmp = {
      enable = true;
      settings = {
        completion.completeopt = "menu,menuone,noselect,preview";
        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {
            name = "look";
            keywordLength = 2;
            option = {
              convert_case = true;
              loud = true;
            };
          }
          {name = "path";}
          {name = "buffer";}
          {name = "nvim_lua";}
        ];
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
        };
        snippet.expand = "luasnip";
      };
    };
  };
}
