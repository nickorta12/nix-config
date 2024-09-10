{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #crane = {
    #  url = "github:ipetkov/crane";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
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
        pkgsInput = unstable;
        desktop = true;
      };

      tesla = libx.mkHost {
        hostname = "tesla";
        pkgsInput = unstable;
        desktop = true;
      };

      volta = libx.mkHost {
        hostname = "volta";
        pkgsInput = nixpkgs;
        desktop = true;
      };
    };
  };
}
