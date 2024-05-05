{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "emacs";
  };

  home.shellAliases = {
    g = "git";
    build-conf = "sudo nixos-rebuild switch";
  };

  # Custom functions
  programs.zsh.initExtra =
    ''
      nrun() {
        nix run nixpkgs#"$1"
      }

      # -- grml stuff --
    ''
    + builtins.readFile ./grml.zsh;
}
