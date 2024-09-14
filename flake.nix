{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    unstable,
    home-manager,
    ...
  }: let
    inherit (self) outputs;
    libx = import ./lib.nix {
      inherit self inputs outputs;
    };
  in {
    packages = libx.forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      motherbrain = libx.mkHost {
        hostname = "motherbrain";
        desktop = true;
      };

      tesla = libx.mkHost {
        hostname = "tesla";
        desktop = true;
      };

      volta = libx.mkHost {
        hostname = "volta";
        homeManager = false;
        desktop = true;
      };
    };

    darwinConfigurations = {
      Maxwell = libx.mkDarwin {
        hostname = "Maxwell";
      };
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
