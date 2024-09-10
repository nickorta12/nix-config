{
  self,
  inputs,
  outputs,
  ...
}: let
  mkHome = {
    hostname,
    user,
    desktop,
    system,
  }:
    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${user}" = import ./. + "/home/${hostname}.nix";
        extraSpecialArgs = {
          inherit self inputs outputs hostname desktop;
          username = user;
        };
      };
    };
in {
  mkHost = {
    hostname,
    pkgsInput ? inputs.unstable,
    user ? "norta",
    desktop ? null,
    system ? "x86_64-linux",
  }:
    pkgsInput.lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs hostname desktop;
      };
      modules = [
        "./host/${hostname}"
        (mkHome {inherit hostname desktop user system;})
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
