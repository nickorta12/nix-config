{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bitwarden
    # Matrix client
    fractal
    # IRC client
    halloy
    thunderbird
    obsidian
    # Games
    lutris
    heroic
    bottles
    planify

    # Gnome
    dconf-editor
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
}
