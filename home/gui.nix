{pkgs, ...}: {
  home.packages = with pkgs; [
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
    gnome.dconf-editor
  ];
}
