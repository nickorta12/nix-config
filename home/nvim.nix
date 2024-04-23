{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set ts=2
      set sw=2
      set expandtab
      set smarttab
      set smartindent
      set autoindent
      set number
      set relativenumber
    '';
  };
}
