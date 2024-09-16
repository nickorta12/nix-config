{
  self,
  pkgs,
  outputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with outputs.overlays; [
      unstable-packages
    ];
  };

  environment = {
    systemPackages = [] ++ import "${self}/common/base-packages.nix" {inherit pkgs;};
  };

	system.defaults = {
    finder = {
      FXPreferredViewStyle = "Nlsv";
    };
	};

  services.nix-daemon.enable = true;
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "nicko"
      ];
    };
  };

  programs.zsh = {
    enable = true;
  };

  users.users."nicko" = {
    description = "Nicholas Orta";
    home = "/Users/nicko";
    #extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };
}
