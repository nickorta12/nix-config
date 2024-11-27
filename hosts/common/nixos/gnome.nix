{pkgs, ...}: {
  imports = [
    ./desktop.nix
  ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-connections
    gnome-tour
    gnome.geary
    gnome.gnome-contacts
    gnome.gnome-maps
    gnome.gnome-music
    gnome.simple-scan
    gnome.yelp
    snapshot
  ];
}
