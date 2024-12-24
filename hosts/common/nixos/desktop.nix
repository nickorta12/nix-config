{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bitwarden
    # Matrix clients
    element-desktop-wayland
    fractal
    # IRC client
    halloy
    thunderbird
    obsidian
    # Games
    lutris
    heroic
    bottles
    factoriolab
    yafc-ce

    # Gnome
    dconf-editor

    # Misc
    planify
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      font-awesome
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      roboto

      nerd-fonts.fira-code
    ];

    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;
    };
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {default = ["org.wezfurlong.wezterm.desktop"];};
  };
}
