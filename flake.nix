{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gclone = {
      url = "github:nickorta12/gclone";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    markitdown = {
      url = "github:nickorta12/markitdown-flake";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nh-darwin = {
      url = "github:ToyVo/nh_darwin";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
    nickvim = {
      url = "github:nickorta12/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    inherit (self) outputs;
    libx = import ./lib.nix {
      inherit self inputs outputs;
      inherit (nixpkgs) lib;
    };
  in {
    packages = libx.forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      import ./packages pkgs);

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
        root = true;
      };
    };

    darwinConfigurations = {
      Maxwell = libx.mkDarwin {
        hostname = "Maxwell";
      };
    };

    colmena = {
      meta = {
        nixpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        specialArgs = {
          inherit self inputs outputs;
          isLinux = true;
          isDarwin = false;
        };
      };

      volta = {
        imports =
          [
            ./hosts/volta/configuration.nix
            inputs.sops-nix.nixosModules.sops
          ]
          ++ (libx.mkHomeNixos {
            hostname = "volta";
            user = "norta";
            desktop = false;
            system = "x86_64-linux";
            root = true;
          });

        deployment = {
          targetHost = "10.25.0.2";
          buildOnTarget = true;
        };
        networking.hostName = "volta";
      };
    };

    overlays = import ./overlays;
  };

  nixConfig = {
    extra-substituters = ["https://ghostty.cachix.org"];
    extra-trusted-public-keys = ["ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="];
  };
}
