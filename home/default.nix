{
  inputs,
  pkgs,
  ...
}: {
  home.username = "norta";
  home.homeDirectory = "/home/norta";

  imports = [
    ./git.nix
    ./nvim.nix
    ./wezterm
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    alejandra
    neofetch
    fzf
    jq
    aria2
    socat
    nmap
    ipcalc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    nix-output-monitor
    glow
    btop
    iotop
    iftop

    strace
    lsof
    sysstat
    ethtool
    pciutils
    usbutils
    procs
    hexyl
    hyperfine
    bottom
    just
    bandwhich
    lazygit
    tmux
    zellij
    tokei
    xh

    nil
    nixpkgs-fmt
  ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.atuin = {
    enable = true;
  };

  programs.htop = {
    enable = true;
    settings = {
      show_program_path = 0;
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          raindropio
          ublock-origin
          vimium
        ];
      };
    };
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
  };

  programs.zoxide = {
    enable = true;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
