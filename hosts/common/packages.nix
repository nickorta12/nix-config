# Packages I want installed everywhere
{
  pkgs,
  lib,
  isDarwin,
  isLinux,
  system,
  inputs,
  ...
}: let
  markitdown = inputs.markitdown.packages.${system}.markitdown;
in {
  environment.systemPackages = with pkgs;
    [
      # Nix tools
      nix-tree

      # Encryption
      age
      rage
      sops

      # General CLI tools
      bat
      dua
      duf
      fd
      file
      fzf
      gawk
      glow
      gnupg
      gnused
      gnutar
      hexyl
      hyperfine
      iftop
      ipcalc
      jq
      markitdown
      neofetch
      nmap
      procs
      tmux
      tree
      viddy
      which
      zellij
      zstd

      # Monitoring
      aria2
      bandwhich
      bottom
      btop
      htop
      ripgrep

      # Other
      todoist
    ]
    ++ lib.optionals isLinux [
      ethtool
      iotop
      lsof
      pciutils
      strace
      sysstat
      usbutils
    ]
    ++ lib.optionals isDarwin [
      coreutils
      m-cli
    ];
}
