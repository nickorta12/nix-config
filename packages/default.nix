pkgs: {
  rgl = pkgs.writeShellScriptBin "rgl" ''
    ${pkgs.ripgrep}/bin/rg --pretty $@ | ${pkgs.less}/bin/less -FR
  '';
  pam-watchid = pkgs.callPackage ./pam-watchid.nix {};
}
