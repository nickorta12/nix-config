{
  pkgs,
  lib,
  isLinux,
  isDarwin,
  inputs,
  system,
  ...
}: let
  getPkg = name: inputs.${name}.packages.${system}.default;
  gclone = getPkg "gclone";
in {
  imports = [
    ./git.nix
    ./zsh.nix
    ./ssh.nix
    ./scripts
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
      colmena
      deadnix
      ffmpeg
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
      manix
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
      viddy
      zellij
      zstd
      # Custom stuff
      gclone
    ]
    ++ lib.optionals isLinux [
      ethtool
      iotop
      strace
      sysstat
      usbutils
    ]
    ++ lib.optionals isDarwin [
      coreutils
      m-cli
      nixos-rebuild
    ];

  programs = {
    atuin = {
      enable = true;
      flags = [
        "--disable-up-arrow"
      ];
      settings = {
        update_check = false;
        sync_address = "http://10.25.0.2:8888";
      };
    };

    bat = {
      enable = true;
      config = {
        map-syntax = [
          "flake.lock:JSON"
        ];
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
    };

    helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
        };
        theme = "dracula";
      };
    };

    htop = {
      enable = true;
      settings = {
        show_program_path = 0;
      };
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    yazi = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };
  };
}
