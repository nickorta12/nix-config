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
    # Better view of git diff markers
    gitgutter.enable = true;
    # Indent guides
    indent-blankline.enable = true;
    # Better file finder
    yazi.enable = true;
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
