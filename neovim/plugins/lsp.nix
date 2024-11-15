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
        (nmap "go" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nmap "gr" "vim.lsp.buf.references()" "Go to references")
        (nmap "gS" "vim.lsp.buf.signature_help()" "Show signature help")
        (nmap "<F2>" "vim.lsp.buf.rename()" "Rename")
        (nmap "<F4>" "vim.lsp.buf.code_action()" "Code action")

        (nmap "<leader>vd" "vim.lsp.buf.definition()" "Go to definition")
        (nmap "<leader>vD" "vim.lsp.buf.declaration()" "Go to declaration")
        (nmap "<leader>vi" "vim.lsp.buf.implementation()" "Go to implementation")
        (nmap "<leader>vo" "vim.lsp.buf.type_definition()" "Go to type definition")
        (nmap "<leader>vr" "vim.lsp.buf.references()" "Go to references")
        (nmap "<leader>vs" "vim.lsp.buf.signature_help()" "Show signature help")
        (nmap "<leader>vc" "vim.lsp.buf.code_action()" "Code action")
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

    trouble.enable = true;
    nvim-lightbulb.enable = true;
  };
}
