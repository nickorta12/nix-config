{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    completionInit = "autoload -U compinit && compinit -u";
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "emacs";
  };

  programs.zsh.initExtraFirst = let
    direnv = lib.getExe pkgs.direnv;
  in ''
    (( ''${+commands[direnv]} )) && emulate zsh -c "$(${direnv} export zsh)"

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    (( ''${+commands[direnv]} )) && emulate zsh -c "$(${direnv} hook zsh)"
  '';

  # Custom functions
  programs.zsh.initExtra =
    (lib.readFile ./grml.zsh)
    + ''
      source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"

      # bindkey  "^[[H"   beginning-of-line
      # bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char

      cdtop() {
        local top_level=$(git rev-parse --show-toplevel 2>/dev/null)
        if [ $? -eq 0 ]; then
          cd $top_level
        fi
      }

      catwhich() {
        if [[ -z "$1" ]]; then
          echo "Enter command name"
          return 1
        fi
        local command_type="$(whence -w "$1" | cut -d" " -f2)"
        case "$command_type" in
          function)
            whence -f "$1" | bat -lzsh
            ;;
          alias)
            which "$1" | bat -lzsh
            ;;
          command)
            bat $(which "$1")
            ;;
          *)
            echo "Invalid command to view"
            return 1
              ;;
        esac
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

      # To customize prompt, run `p10k configure` and save to nix-config
      source ${./p10k.zsh}
    '';
}
