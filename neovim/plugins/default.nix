{
  imports = [
    ./telescope.nix
    ./git.nix
    ./lsp.nix
    ./treesitter.nix
  ];

  plugins = {
    # Reopens files at last edit position
    lastplace.enable = true;
    # Better comments
    comment.enable = true;
    # Auto make pairs
    nvim-autopairs.enable = true;
    # Better buffer delete
    vim-bbye.enable = true;
    # Nicer tab line
    bufferline = {
      enable = true;
      settings.options = {
        mode = "tabs";
        diagnostics = "nvim_lsp";
        separator_style = "slant";
      };
    };
    # Better status line
    lualine.enable = true;
    # Indent guides
    indent-blankline.enable = true;
    # Edit files in a buffer
    oil.enable = true;
    # Better file finder
    yazi = {
      enable = true;
      settings = {
        enable_mouse_support = true;
      };
    };
    # Sidebar
    neo-tree = {
      enable = true;
      closeIfLastWindow = false;
      filesystem = {
        useLibuvFileWatcher = true;
        followCurrentFile.enabled = true;
      };
    };
    # Better surrounding of characters
    nvim-surround = {
      enable = true;
      # settings.keymaps = {
      #   insert = "<C-g>z";
      #   insert_line = "<C-g>Z";
      #   normal = "gz";
      #   normal_cur = "gZ";
      #   normal_line = "gzz";
      #   normal_cur_line = "gZZ";
      #   visual = "gz";
      #   visual_line = "gZ";
      #   delete = "gzd";
      #   change = "gzr";
      #   change_line = "gzR";
      # };
    };

    # Better vim motions
    flash.enable = true;

    # Better undo handling
    undotree = {
      enable = true;
      settings = {
        SetFocusWhenToggle = 1;
        HighlightChangedText = 1;
        WindowLayout = 3;
      };
    };

    # # Fancy ui
    # noice = {
    #   enable = true;
    # };
  };
}
