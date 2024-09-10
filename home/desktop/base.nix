{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden
    obsidian
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
}
