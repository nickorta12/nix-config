{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Nicholas Orta";
    userEmail = "nickorta12@gmail.com";
    aliases = {
      aa = "add -A .";
      br = "branch";
      ci = "commit";
      co = "checkout";
      cob = "checkout -b";
      d = "diff";
      dc = "diff --cached";
      f = "fetch --tags";
      fp = "fetch --prune --tags";
      ol = "log --oneline --all --decorate --graph --color=always";
      olh = "ol -10";
      s = "show";
      st = "status";
      amend = "commit --amend --no-edit --date=now";
      retrack = "update-index --no-assume-unchanged";
      show-author = "! git show --pretty=fuller --color=always | head -n5";
      unstage = "reset HEAD --";
      untrack = "update-index --assume-unchanged";
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    git-crypt
  ];
}
