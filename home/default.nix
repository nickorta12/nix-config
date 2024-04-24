{
  inputs,
  pkgs,
  ...
}: {
  home.username = "norta";
  home.homeDirectory = "/home/norta";

  imports = [
    ./git.nix
    ./gui.nix
    ./nvim.nix
    ./shell.nix
    ./wezterm
    ./zsh.nix
  ];

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          raindropio
          ublock-origin
          vimium
        ];
      };
    };
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
