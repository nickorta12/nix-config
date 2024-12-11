{isLinux, ...}: {
  programs = {
    # zsh.initExtra = ''source "${pkgs.wezterm}/etc/profile.d/wezterm.sh"'';
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
      enableZshIntegration = isLinux;
    };
  };
}
