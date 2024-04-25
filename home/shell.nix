{pkgs, ...}: {
  # -- CLI Packages --
  home.shellAliases = {
    cd = "z";
  };

  home.packages = with pkgs; [
    alejandra
    aria2
    bandwhich
    bottom
    btop
    ethtool
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
    iotop
    ipcalc
    jq
    just
    lazygit
    lsof
    neofetch
    nil
    nix-output-monitor
    nixpkgs-fmt
    nmap
    pciutils
    procs
    socat
    strace
    sysstat
    tmux
    tokei
    tree
    usbutils
    which
    xh
    zellij
    zstd
  ];

  # -- Modules Config --

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      update_check = false;
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.htop = {
    enable = true;
    settings = {
      show_program_path = 0;
    };
  };
}
