{keymap, ...}: {
  plugins = {
    telescope = {
      enable = true;
      keymaps = let
        inherit (keymap) keysToAttrs;
        mk = keymap.mkKeyBasic;
      in
        keysToAttrs [
          (mk "<leader>sf" "find_files" "Search Files")
          (mk "<leader>sa" "find_files hidden=true no_ignore=true follow=true" "Search All")
          (mk "<leader>sr" "live_grep" "Search Ripgrep")
          (mk "<leader>sg" "git_files" "Search Git")
          (mk "<leader>sz" "current_buffer_fuzzy_find" "Search Fuzzy")
          (mk "<leader>sb" "buffers" "Search Buffers")
          (mk "<leader>sh" "help" "Search Help")
          (mk "<leader>sd" "diagnostics" "Search Diagnostics")
          (mk "<leader>sc" "commands" "Search Commands")
          (mk "<leader>sw" "grep_string" "Search Word")
          (mk "<leader>sk" "keymaps" "Search Keymaps")
          (mk "<leader>so" "oldfiles" "Search Oldfiles")
          (mk "<leader>ss" "builtin" "Search Builtins")
          (mk "<leader>sl" "lsp_document_symbols" "Search LSP Document Symbols")
          (mk "<leader>sL" "lsp_dynamic_workspace_symbols" "Search LSP Workspace Symbols")
          (mk "<leader>sR" "resume" "Resume previous Search")
        ];
    };

    web-devicons.enable = true;
  };
}
