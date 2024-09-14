{inputs}: {
  unstable-packages = final: _prev: {
    unstable = inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
