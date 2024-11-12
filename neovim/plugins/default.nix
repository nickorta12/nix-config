{...}: {
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
    # Nicer tab line
    barbar.enable = true;
    # Better status line
    lualine.enable = true;
    # Indent guides
    indent-blankline.enable = true;
    # Better file finder
    yazi.enable = true;
    # Better surrounding of characters
    nvim-surround = {
      enable = true;
      settings.keymaps = {
        insert = "<C-g>z";
        insert_line = "<C-g>Z";
        normal = "gz";
        normal_cur = "gZ";
        normal_line = "gzz";
        normal_cur_line = "gZZ";
        visual = "gz";
        visual_line = "gZ";
        delete = "gzd";
        change = "gzr";
        change_line = "gzR";
      };
    };

    # Better vim motions
    leap.enable = true;

    # Better undo handling
    undotree = {
      enable = true;
      settings = {
        FocusOnToggle = true;
        HighlightChangedText = true;
      };
    };
  };
}
