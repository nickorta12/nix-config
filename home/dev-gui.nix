{...}: {
  programs.zed-editor = {
    enable = true;
    userSettings = {
      features = {
        copilot = false;
      };
      vim_mode = true;
    };
  };
}
