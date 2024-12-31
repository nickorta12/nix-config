{
  inputs,
  pkgs,
  ...
}: let
  vscodeExtensions =
    inputs.vscode-extensions.extensions.x86_64-linux.vscode-marketplace;
in {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    package = pkgs.vscode;
    extensions = with vscodeExtensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      redhat.ansible
      ms-python.vscode-pylance
      ms-python.python
      ms-python.debugpy
      charliermarsh.ruff
      redhat.vscode-yaml
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "editor.codeLens" = false;
      "editor.fontFamily" = "Fira Code";
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "editor.wordWrapColumn" = 88;
      "editor.minimap.enabled" = false;
      "editor.confirmDragAndDrop" = false;
      "editor.inlayHints.enabled" = "offUnlessPressed";

      "explorer.confirmDelete" = false;

      "files.insertFinalNewLine" = true;
      "files.trimTrailingWhitespace" = true;

      "security.workspace.trust.enabled" = false;

      "telemetry.telemetryLevel" = "off";
      "redhat.telemtry.enabled" = false;

      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 0;

      "workbench.colorTheme" = "One Dark Pro";
      "workbench.statusBar.visible" = true;
      "workbench.startupEditor" = "none";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "oneDarkPro.vivid" = true;
      "oneDarkPro.editorTheme" = "One Dark Pro Darker";

      "python.languageServer" = "Pylance";
      "python.analysis.typeCheckingMode" = "basic";
      "python.analysis.inlayHints.callArgumentNames" = "all";
      "python.analysis.useLibraryCodeForTypes" = true;
      "[python]" = {
        "editor.rulers" = [88];
        "editor.formatOnSave" = true;
        "editor.defualtFormatter" = "charlemarsh.ruff";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = "explicit";
        };
      };

      "rust-analyzer.procMacro.enable" = true;
      "[rust]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
    };
  };
}
