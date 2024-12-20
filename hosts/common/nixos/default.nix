{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../packages.nix
    ./kexec.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  environment = {
    shellAliases = {
      sctl = "systemctl";
      jctl = "journalctl";
    };
  };

  time.timeZone = "America/Denver";

  programs = {
    less.lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/norta/nix-config";
    };
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "norta"
      ];
      flake-registry = builtins.toFile "global-registry.json" (
        builtins.toJSON {
          "flakes" = [];
          "version" = 2;
        }
      );
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry =
      {
        n.flake = inputs.self;
      }
      // (lib.mapAttrs (_: value: {flake = value;}) inputs);

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath =
      lib.mkForce
      (lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
        config.nix.registry);
  };

  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    # Enable ssh
    openssh.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };
  console.useXkbConfig = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.norta = {
    isNormalUser = true;
    description = "Nicholas Orta";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };
}
