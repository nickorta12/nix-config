{
  pkgs,
  self,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "nixpkgs-dir" ''
      echo $(nix eval --impure --raw --expr '(builtins.getFlake "${self}").inputs.nixpkgs.sourceInfo')
    '')
    (pkgs.writeShellScriptBin "nix-darwin-dir" ''
      echo $(nix eval --impure --raw --expr '(builtins.getFlake "${self}").inputs.nix-darwin.sourceInfo')
    '')
    (pkgs.writeShellScriptBin "home-manager-dir" ''
      echo $(nix eval --impure --raw --expr '(builtins.getFlake "${self}").inputs.home-manager.sourceInfo')
    '')
    (pkgs.writeShellScriptBin "nshell" ''
      args=()
      for i in $@; do
          args+=("nixpkgs#$i")
      done
      nix shell "''${args[@]}"
    '')
    (pkgs.writeShellScriptBin "nrun" ''
      pkg="nixpkgs#$1"
      shift
      nix run "$pkg" -- $@
    '')
    (pkgs.writeShellScriptBin "symlink-to-regular" ''
      cp --remove-destination "$(readlink "$1")" "$1"
    '')
  ];

  home.shellAliases = {
    cd-nixpkgs = "cd $(nixpkgs-dir)";
    cd-nix-darwin = "cd $(nix-darwin-dir)";
    cd-home-manager = "cd $(home-manager-dir)";
    nix-repl = "nix repl --expr '{pkgs = import <nixpkgs>{};}'";
    flake-repl = "nix repl --expr 'builtins.getFlake \"${self}\"'";
    jqless = "jq -C | less -R";
  };
}
