{...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };
    opts = {
      number = true;
      relativenumber = true;

      expandtab = true;
      smarttab = true;
      smartindent = true;
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      hlsearch = false;
      incsearch = true;

      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;

      wrap = false;

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
    };
  };
}
