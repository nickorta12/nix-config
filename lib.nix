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
    isLinux ? true,
    system,
  }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users."${user}" =
        if isLinux
        then import (./. + "/nixos/${hostname}/home.nix")
        else import (./. + "/darwin/${hostname}/home.nix");
      extraSpecialArgs = {
        inherit self inputs isLinux outputs hostname desktop;
        isDarwin = !isLinux;
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
    inputs.nixvim.homeManagerModules.nixvim
    (mkHome
      {inherit hostname user desktop system;})
  ];
  mkHomeDarwin = {
    hostname,
    user,
    system,
  }: [
    inputs.home-manager.darwinModules.home-manager
    inputs.nixvim.darwinModules.nixvim
    (mkHome
      {
        inherit hostname user system;
        isLinux = false;
      })
  ];
in {
  mkNixos = {
    hostname,
    homeManager ? true,
    user ? "norta",
    desktop ? null,
    system ? "x86_64-linux",
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs hostname desktop;
      };
      modules =
        [
          (./. + "/nixos/${hostname}/configuration.nix")
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeNixos {inherit hostname desktop user system;});
    };

  mkDarwin = {
    hostname,
    homeManager ? true,
    user ? "nicko",
    system ? "aarch64-darwin",
  }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self inputs outputs hostname;
      };
      modules =
        [
          (./. + "/darwin/${hostname}/configuration.nix")
          {
            nixpkgs.hostPlatform = system;
          }
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeDarwin {inherit hostname user system;});
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
