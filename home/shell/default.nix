{
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
        package.disabled = true;
        rust.disabled = true;
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
