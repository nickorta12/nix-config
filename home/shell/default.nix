{
  pkgs,
  lib,
  isLinux,
  ...
}: {
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.shellAliases = {
    cd = "z";
    g = "git";
  };

  home.packages = with pkgs;
    [
      alejandra
      aria2
      bandwhich
      bottom
      btop
      file
      fzf
      gawk
      glow
      gnupg
      gnused
      gnutar
      hexyl
      hyperfine
      hub
      iftop
      ipcalc
      jq
      just
      lazygit
      lsof
      neofetch
      nil
      nix-output-monitor
      nixpkgs-fmt
      nmap
      pciutils
      procs
      socat
      tmux
      tokei
      tree
      which
      xh
      zellij
      zstd
    ]
    ++ lib.optionals isLinux [
      ethtool
      iotop
      strace
      sysstat
      usbutils
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

  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      update_check = false;
      sync_address = "http://192.168.0.78:8888";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "flake.lock:JSON"
      ];
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
      };
      theme = "dracula";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.htop = {
    enable = true;
    settings = {
      show_program_path = 0;
    };
  };
}
