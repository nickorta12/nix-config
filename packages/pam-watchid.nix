# Taken from https://github.com/mirkolenz/nixos/blob/102344e45ba650160219c7588a0d7be237626ab0/overlays/packages/pam-watchid.nix
{
  lib,
  fetchFromGitHub,
  swift,
  swiftPackages,
}:
swiftPackages.stdenv.mkDerivation {
  name = "pam-watchid";
  src = fetchFromGitHub {
    owner = "biscuitehh";
    repo = "pam-watchid";
    rev = "6061b86e96c766085718d4589c974184d86cf1d3";
    hash = "sha256-EJekXScC2Oay2ySb+xT1VusZ265WNh3JjezsbSBSEB4=";
  };
  nativeBuildInputs = [swift];
  # needs macos 15, but swift failes with apple-sdk_15
  # patchPhase = ''
  #   runHook prePatch

  #   substituteInPlace watchid-pam-extension.swift \
  #     --replace-fail \
  #     'return .deviceOwnerAuthenticationWithBiometricsOrWatch' \
  #     'return .deviceOwnerAuthenticationWithBiometricsOrCompanion'

  #   runHook postPatch
  # '';
  buildPhase = ''
    runHook preBuild

    swiftc watchid-pam-extension.swift \
      -o pam_watchid.so \
      -emit-library \
      -Ounchecked

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/pam
    cp pam_watchid.so $out/lib/pam

    runHook postInstall
  '';
  meta = with lib; {
    homepage = "https://github.com/biscuitehh/pam-watchid";
    description = "PAM plugin module that allows the Apple Watch to be used for authentication";
    license = licenses.unlicense;
    maintainers = with maintainers; [mirkolenz];
    platforms = platforms.darwin;
  };
}
