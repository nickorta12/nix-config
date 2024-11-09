{inputs, ...}: {
  vte-fix = _final: _prev: {
    vte = inputs.nixpkgs-vte-fix.legacyPackages.aarch64-darwin.vte;
  };
}
