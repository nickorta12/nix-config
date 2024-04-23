{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "emacs";
    shellAliases = {
      g = "git";
    };
  };
}
