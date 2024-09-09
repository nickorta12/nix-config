{
  pkgs,
  config,
  ...
}: {
  # Gaming settings
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  hardware.opengl = {
    enable = true;
  };
}
