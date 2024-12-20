{inputs, ...}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
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
        inline_height = 20;
        invert = true;
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

    htop = {
      enable = true;
      settings = {
        show_program_path = 0;
      };
    };

    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };

    yazi = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };
  };
}
