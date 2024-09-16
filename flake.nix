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
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    unstable,
    home-manager,
    deploy-rs,
    ...
  }: let
    inherit (self) outputs;
    libx = import ./lib.nix {
      inherit self inputs outputs;
    };
  in {
    packages = libx.forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

    nixosConfigurations = {
      motherbrain = libx.mkNixos {
        hostname = "motherbrain";
        desktop = true;
      };

      tesla = libx.mkNixos {
        hostname = "tesla";
        desktop = true;
      };

      volta = libx.mkNixos {
        hostname = "volta";
        desktop = false;
      };
    };

    darwinConfigurations = {
      Maxwell = libx.mkDarwin {
        hostname = "Maxwell";
      };
    };

    deploy.nodes.volta = {
      sshUser = "root";
      hostname = "192.168.0.78";
      remoteBuild = true;

      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.volta;
    };

    overlays = import ./overlays {inherit inputs;};

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
