{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/common.nix
    ../common/desktop.nix
    ../common/gnome.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tesla";
  networking.networkmanager.enable = true;

  security.sudo.extraRules = [
    {
      users = ["norta"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/nh";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  services.xserver.videoDrivers = ["nvidia"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
