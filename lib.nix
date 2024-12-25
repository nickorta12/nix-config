{
  self,
  inputs,
  outputs,
  lib,
  ...
}: let
  commonHome = {hostname}: {...}: {
    imports = [
      (./. + "/hosts/${hostname}/home.nix")
    ];
  };
  mkHome = {
    hostname,
    user,
    desktop ? null,
    isLinux ? true,
    root ? false,
    system,
  }: {
    home-manager =
      lib.recursiveUpdate {
        backupFileExtension = "bak";
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${user}" = commonHome {inherit hostname;};
        extraSpecialArgs = {
          inherit self inputs isLinux outputs hostname desktop system;
          isDarwin = !isLinux;
        };
      }
      (lib.optionalAttrs
        root {
          users.root = {...}: {
            imports = [
              ./hosts/${hostname}/root.nix
            ];
          };
        });
  };
  mkHomeNixos = {
    hostname,
    user,
    desktop,
    system,
    root ? false,
  }: [
    inputs.home-manager.nixosModules.home-manager
    (mkHome
      {inherit hostname user desktop system root;})
  ];
  mkHomeDarwin = {
    hostname,
    user,
    system,
  }: [
    inputs.home-manager.darwinModules.home-manager
    (mkHome
      {
        inherit hostname user system;
        isLinux = false;
      })
  ];
in {
  inherit mkHomeNixos;

  mkNixos = {
    hostname,
    homeManager ? true,
    user ? "norta",
    desktop ? null,
    system ? "x86_64-linux",
    root ? false,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs hostname desktop system;
        isLinux = true;
        isDarwin = false;
      };
      modules =
        [
          (./. + "/hosts/${hostname}/configuration.nix")
          {
            networking.hostName = hostname;
          }
          inputs.sops-nix.nixosModules.sops
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeNixos {inherit hostname desktop user system root;});
    };

  mkDarwin = {
    hostname,
    homeManager ? true,
    user ? "nicko",
    system ? "aarch64-darwin",
  }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit self inputs outputs hostname system;
        isLinux = false;
        isDarwin = true;
      };
      modules =
        [
          inputs.nh-darwin.nixDarwinModules.prebuiltin
          (./. + "/hosts/${hostname}/configuration.nix")
          {
            nixpkgs.hostPlatform = system;
          }
          inputs.sops-nix.darwinModules.sops
        ]
        ++ inputs.nixpkgs.lib.optionals homeManager (mkHomeDarwin {inherit hostname user system;});
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
