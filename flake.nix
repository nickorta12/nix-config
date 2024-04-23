{
  description = "Nick's OS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgsUnstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgsUnstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.motherbrain = nixpkgs.lib.nixosSystem rec {
      inherit system;

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.norta = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            pkgs = pkgs-unstable;
            pkgs-stable = nixpkgs;
          };
        }
      ];
    };
  };
}
