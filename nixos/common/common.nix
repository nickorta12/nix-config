{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./kexec.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  environment = {
    systemPackages = [] ++ import "${self}/common/base-packages.nix" {inherit pkgs;};
    shellAliases = {
      sctl = "systemctl";
      jctl = "journalctl";
    };
  };

  time.timeZone = "America/Denver";

  programs = {
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
    };
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
}
