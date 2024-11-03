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

    conform-nvim.enable = true;
    rustaceanvim.enable = true;
  };
}
