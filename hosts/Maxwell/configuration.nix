{
  self,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/packages.nix
    ../common/dev.nix
    ../common/sops.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays =
      [
        (import self.inputs.rust-overlay)
      ]
      ++ lib.attrValues self.overlays;
  };

  environment = {
    systemPackages = with pkgs; [
      iproute2mac
      devenv
      lima
      prismlauncher
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

  # See when this can work
  # environment.etc."pam.d/sudo_local" = {
  #   enable = true;
  #   text = ''
  #     auth       optional       ${lib.getLib pkgs.pam-reattach}/lib/pam/pam_reattach.so
  #     auth       sufficient     ${lib.getLib pkgs.pam-watchid}/lib/pam/pam_watchid.so
  #     auth       sufficient     pam_tid.so
  #   '';
  # };
  networking.hostName = "Maxwell";

  nix = {
    # package = pkgs.nixVersions.latest;
    # Maybe versions post 2.22 might be weird on darwin
    # Or just use lix for now
    package = pkgs.nixVersions.stable;
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
      enableBashCompletion = false;
      enableGlobalCompInit = false;
    };
  };

  users.users."nicko" = {
    description = "Nicholas Orta";
    home = "/Users/nicko";
    shell = pkgs.zsh;
  };
}
