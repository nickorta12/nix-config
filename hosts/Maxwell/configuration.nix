{
  self,
  pkgs,
  ...
}: {
  imports = [
    ../common/packages.nix
    ../common/dev.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [(import self.inputs.rust-overlay)];
  };

  environment = {
    systemPackages = [
      pkgs.lima
    ];
  };

  system.stateVersion = 5;

  system.defaults = {
    finder = {
      FXPreferredViewStyle = "Nlsv";
    };
  };

  services = {
    nix-daemon.enable = true;
    tailscale.enable = true;
  };

  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  networking.hostName = "Maxwell";

  nix = {
    # package = pkgs.nixVersions.latest;
    # Maybe versions post 2.22 might be weird on darwin
    # Or just use lix for now
    package = pkgs.lix;
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://toyvo.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "toyvo.cachix.org-1:s++CG1te6YaS9mjICre0Ybbya2o/S9fZIyDNGiD4UXs="
      ];
      trusted-users = [
        "nicko"
      ];
    };
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  users.users."nicko" = {
    description = "Nicholas Orta";
    home = "/Users/nicko";
    shell = pkgs.zsh;
  };
}