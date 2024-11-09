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
    root ? false,
    system,
  }: {
    home-manager = {
      backupFileExtension = "bak";
      useGlobalPkgs = true;
      useUserPackages = true;
      users."${user}" = commonHome {inherit isLinux hostname;};
      users.root = lib.optionalAttrs root ({...}: {
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
          ./nixos/${hostname}/root.nix
        ];
      });
      extraSpecialArgs = {
        inherit self inputs isLinux outputs hostname desktop system;
        isDarwin = !isLinux;
      };
    };
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

  keymap = let
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
  in {
    inherit mkKey mkKeyBasic keysToAttrs;
  };
in {
  inherit keymap mkHomeNixos;

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
        inherit self inputs outputs hostname desktop;
      };
      modules =
        [
          (./. + "/nixos/${hostname}/configuration.nix")
          {
            networking.hostName = hostname;
          }
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
