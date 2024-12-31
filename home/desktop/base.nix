{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../ghostty
    ./firefox.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    inputs.ghostty.packages.x86_64-linux.default
    bitwarden
    obsidian
    todoist-electron
  ];
}
