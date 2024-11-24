{pkgs, ...}: {
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      extensions = ["rust-src" "rust-analyzer"];
    })
    cargo-update
    cargo-outdated
    cargo-edit
    just
    poetry
    uv
  ];
}
