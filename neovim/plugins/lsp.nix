{keymap, ...}: let
  nmap = keymap.mkKeyLua "n";
in {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          settings.formatting.command = ["alejandra"];
          onAttach.function = "client.server_capabilities.semanticTokensProvider = nil";
        };
        pyright.enable = true;
      };
      capabilities = "capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)";
      keymaps.extra = [
        (nmap "K" "vim.lsp.buf.hover()" "Hover")
        (nmap "gd" "vim.lsp.buf.definition()" "Go to definition")
        (nmap "gD" "vim.lsp.buf.declaration()" "Go to declaration")
        (nmap "gi" "vim.lsp.buf.implementation()" "Go to implementation")
      ];
    };

    lspkind.enable = true;
    lsp-status.enable = true;
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          nix = ["alejandra"];
          python = ["ruff_format" "ruff_fix"];
          rust = ["rustfmt"];
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
        /*
           formatters = {
          alejandra.command = lib.getExe pkgs.alejandra;
          ruff_format.command = lib.getExe pkgs.ruff;
          ruff_fix.command = lib.getExe pkgs.ruff;
        };
        */
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
        format_after_save = {
          lsp_format = "fallback";
        };
      };
    };
    rustaceanvim.enable = true;
    lsp-signature = {
      enable = true;
      settings = {
        floating_window = false;
        hint_prefix = "";
        toggle_key = "<C-s>";
      };
    };

    luasnip.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "super-tab";
          "<CR>" = ["accept" "fallback"];
        };
        highlight.use_nvim_cmp_as_default = true;
        accept.auto_brackets.enable = true;
        trigger.signature_help.enable = true;
      };
    };
    # cmp_luasnip.enable = true;
    # cmp-nvim-lsp.enable = true;
    # cmp = {
    #   enable = true;
    #   settings = {
    #     completion.completeopt = "menu,menuone,noselect,preview";
    #     window = {
    #       completion.border = "rounded";
    #       documentation.border = "rounded";
    #     };
    #     sources = [
    #       {name = "nvim_lsp";}
    #       {name = "luasnip";}
    #       {name = "path";}
    #       {name = "buffer";}
    #       {name = "nvim_lua";}
    #     ];
    #     mapping = {
    #       "<C-d>" = "cmp.mapping.scroll_docs(-4)";
    #       "<C-f>" = "cmp.mapping.scroll_docs(4)";
    #       "<C-space>" = "cmp.mapping.complete()";
    #       "<C-e>" = "cmp.mapping.close()";
    #       "<Up>" = "cmp.mapping.select_prev_item()";
    #       "<Down>" = "cmp.mapping.select_next_item()";
    #       "<C-p>" = "cmp.mapping.select_prev_item()";
    #       "<C-n>" = "cmp.mapping.select_next_item()";
    #     };
    #     snippet.expand = "luasnip";
    #   };
    # };
  };
}
