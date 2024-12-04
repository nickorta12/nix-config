{...}: {
  programs.zsh = {
    enable = true;
    completionInit = "autoload -U compinit && compinit -u";
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "emacs";
    # zprof.enable = true;
  };

  home.shellAliases = {
    g = "git";
    build-conf = "sudo nixos-rebuild switch";
  };

  # Custom functions
  programs.zsh.initExtra = ''
    nrun() {
      nix run nixpkgs#"$1"
    }

    mkcd () {
      if (( ARGC != 1 )); then
          printf 'usage: mkcd <new-directory>\n'
          return 1;
      fi
      if [[ ! -d "$1" ]]; then
          command mkdir -p "$1"
      else
          printf '`%s'\''' already exists: cd-ing.\n' "$1"
          fi
          builtin cd "$1"
    }

    WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
    # -- grml stuff --
  '';
  # + builtins.readFile ./grml.zsh;
}
