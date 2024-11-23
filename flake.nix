{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gclone = {
      url = "github:nickorta12/gclone";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh-darwin = {
      url = "github:ToyVo/nh_darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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
      {
        neovim = let
          nixvim = inputs.nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./neovim;
            extraSpecialArgs = {
              inherit (libx) keymap;
            };
          };
        in
          nixvim.makeNixvimWithModule nixvimModule;
      }
      // import ./packages pkgs);

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
        };
      };

      volta = {
        imports =
          [
            ./nixos/volta/configuration.nix
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

    overlays = import ./overlays {inherit inputs;};
  };
}
