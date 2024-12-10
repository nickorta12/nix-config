{pkgs, ...}: {
  # Gaming settings
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = [pkgs.prismlauncher];

  programs.gamemode.enable = true;
  hardware.graphics.enable = true;
}
