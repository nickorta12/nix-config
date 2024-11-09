{
  self,
  pkgs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      self.overlays.vte-fix
    ];
  };

  environment = {
    systemPackages = [] ++ import "${self}/common/base-packages.nix" {inherit pkgs;};
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

  nix = {
    package = pkgs.nixVersions.latest;
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
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
    #extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
}
