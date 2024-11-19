{pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = false;
      nixGrammars = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cpp
        json
        just
        lua
        markdown
        nix
        python
        rust
        toml
        xml
        yaml
      ];
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };

    treesitter-refactor.enable = true;
  };
}
