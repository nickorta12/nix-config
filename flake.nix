{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    gclone = {
      url = "github:nickorta12/gclone";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-darwin"];

      flake = {
        nixosConfigurations.motherbrain = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.norta = import ./home;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };
      };

      perSystem = {pkgs, ...}: {
        packages.rgl = pkgs.writeShellScriptBin "rgl" ''
          ${pkgs.ripgrep}/bin/rg --pretty $@ | ${pkgs.less}/bin/less -FR
        '';
      };
    };
}
