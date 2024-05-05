{
  pkgs,
  inputs,
}: let
  craneLib = inputs.crane.lib.x86_64-linux;
in {
  gclone = craneLib.buildPackage {
    src = craneLib.cleanCargoSource inputs.gclone;
    strictDeps = true;
  };
}
