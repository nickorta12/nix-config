{
  lib,
  isDarwin,
  isLinux,
  ...
}: {
  home.file.".config/ghostty/config".text = lib.concatLines ([
      (lib.readFile ./ghostty.cfg)
    ]
    ++ lib.optionals isLinux [(lib.readFile ./ghostty-linux.cfg)]
    ++ lib.optionals isDarwin [(lib.readFile ./ghostty-mac.cfg)]);

  home.shellAliases = {
    ghostty-docs = "ghostty +show-config --default --docs | bat -lini --file-name ghostty-docs";
  };
}
