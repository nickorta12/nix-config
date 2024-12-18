{pkgs, ...}: {
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

  home.file.".p10k.zsh".source = ./p10k.zsh;

  programs.zsh.initExtraFirst = ''
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi
  '';

  # Custom functions
  programs.zsh.initExtra = ''
    # bindkey  "^[[H"   beginning-of-line
    # bindkey  "^[[F"   end-of-line
    bindkey  "^[[3~"  delete-char
    source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
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

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  '';
  # + builtins.readFile ./grml.zsh;
}
