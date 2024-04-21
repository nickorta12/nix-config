{ inputs, config, pkgs, ... }:

{
  home.username = "norta";
  home.homeDirectory = "/home/norta";
  
  home.packages = with pkgs; [
    neofetch
    fzf
    jq
    aria2
    socat
    nmap
    ipcalc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    
    nix-output-monitor
    glow
    btop
    iotop
    iftop

    strace
    lsof
    sysstat
    ethtool
    pciutils
    usbutils
  ];

  programs.git = {
    enable = true;
    userName = "Nicholas Orta";
    userEmail = "nickorta12@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.atuin = {
    enable = true;
  };

  programs.htop = {
    enable = true;
    settings = {
      show_program_path = 0;
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          vimium
          bitwarden
          ublock-origin
        ];
      };
    };
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
