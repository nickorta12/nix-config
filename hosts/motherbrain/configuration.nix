# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ../common/packages.nix
    ../common/dev.nix
    ../common/nixos
    ../common/nixos/gaming.nix
    ../common/nixos/gnome.nix
    ./hardware-configuration.nix
  ];

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/0c456572-3e2c-4839-8772-326d3133e076";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gvfs-show"
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  programs.hyprland.enable = true;

  # Enable mouse stuff
  hardware.logitech = {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    swayfx

    # Virtualization
    quickemu
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  # Virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    podman.enable = true;
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
