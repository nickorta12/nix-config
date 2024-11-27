# Dev tools for all platforms
{
  pkgs,
  inputs,
  system,
  ...
}: let
  gclone = inputs.gclone.packages.${system}.default;
in {
  enviroment.systemPackages = with pkgs; [
    alejandra
    colmena
    deadnix
    hub
    just
    lazygit
    manix
    nil
    nix-output-monitor
    nixpkgs-fmt
    tokei
    xh

    # Custom stuff
    gclone
  ];
}
