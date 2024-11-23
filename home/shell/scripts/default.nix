{
  pkgs,
  self,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "nixpkgs-dir" ''
      echo $(nix eval --impure --raw --expr '(builtins.getFlake "${self}").inputs.nixpkgs.sourceInfo')
    '')
  ];

  home.shellAliases = {
    cd-nixpkgs = "cd $(nixpkgs-dir)";
    nix-repl = "nix repl --expr '{pkgs = import <nixpkgs>{};}'";
    flake-repl = "nix repl --expr 'builtins.getFlake \"${self}\"'";
  };
}
