{
  self,
  config,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./kexec.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = with outputs.overlays; [
      unstable-packages
    ];
  };

  environment = {
    systemPackages = [] ++ import "${self}/common/base-packages.nix" {inherit pkgs;};
    shellAliases = {
      sctl = "systemctl";
      jctl = "journalctl";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  time.timeZone = "America/Denver";

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  nix.settings = {
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
      "norta"
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable ssh
  services.openssh.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
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
