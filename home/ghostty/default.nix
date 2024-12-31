{
  lib,
  isLinux,
  ...
}: {
  home.file.".config/ghostty/config".text = lib.concatLines ([
      (lib.readFile ./ghostty.cfg)
    ]
    ++ lib.optionals isLinux [(lib.readFile ./ghostty-linux.cfg)]);
}
