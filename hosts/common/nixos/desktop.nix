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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {default = ["org.wezfurlong.wezterm.desktop"];};
  };
}
