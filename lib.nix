{
  self,
  inputs,
  outputs,
  ...
}: let
  mkHome = {
    hostname,
    user,
    desktop ? null,
    system,
  }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users."${user}" = import (./. + "/host/${hostname}/home.nix");
      extraSpecialArgs = {
        inherit self inputs outputs hostname desktop;
        username = user;
      };
    };
  };
  mkHomeNixos = {
    hostname,
    user,
    desktop,
    system,
  }: [
    inputs.home-manager.nixosModules.home-manager
    mkHome
    {inherit hostname user desktop system;}
  ];
  mkHomeDarwin = {
    hostname,
    user,
    system,
  }: [
    inputs.home-manager.darwinModules.home-manager
    mkHome
    {inherit hostname user system;}
  ];
in {
  mkHost = {
    hostname,
    homeManager ? true,
    pkgsInput ? inputs.unstable,
    user ? "norta",
    desktop ? null,
    system ? "x86_64-linux",
  }:
    pkgsInput.lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs hostname desktop;
      };
      modules =
        [
          (./. + "/host/${hostname}/configuration.nix")
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeNixos {inherit hostname desktop user system;});
    };

  mkDarwin = {
    hostname,
    homeManager ? true,
    pkgsInput ? inputs.unstable,
    user ? "nicko",
    system ? "aarch64-darwin",
  }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self inputs outputs hostname;
      };
      modules =
        [
          (./. + "/host/${hostname}/configuration.nix")
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeDarwin {inherit hostname user system;});
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
