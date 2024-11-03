{
  self,
  inputs,
  outputs,
  lib,
  ...
}: let
  commonHome = {
    isLinux,
    hostname,
  }: {...}: {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
      (
        if isLinux
        then (./. + "/nixos/${hostname}/home.nix")
        else (./. + "/darwin/${hostname}/home.nix")
      )
    ];
  };
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
      users."${user}" = commonHome {inherit isLinux hostname;};
      extraSpecialArgs = {
        inherit self inputs isLinux outputs hostname desktop system;
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
    (mkHome
      {inherit hostname user desktop system;})
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

  keymap = {
    mkKeyBasic = key: action: desc: {
      inherit key action;
      options.desc = desc;
    };

    mkKey = mode: key: action: desc:
      lib.recursiveUpdate (mkKeyBasic key action desc) {
        inherit mode;
        options.silent = true;
      };

    keysToAttrs = let
      inherit (lib) listToAttrs map removeAttrs;
    in
      list:
        listToAttrs (map (x: {
            name = x.key;
            value = removeAttrs x ["key"];
          })
          list);
  };
in {
  inherit keymap;

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
          {
            networking.hostName = hostname;
          }
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
          inputs.nh-darwin.nixDarwinModules.prebuiltin
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
