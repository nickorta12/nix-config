{pkgs, ...}: {
  # Gaming settings
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    prismlauncher
    vintagestory
    graalvm-ce
  ];

  programs.gamemode.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-7.0.20"
    "dotnet-runtime-7.0.20"
  ];

  hardware.graphics.enable = true;
}
