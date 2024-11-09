{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPersist = "10m";
    matchBlocks = {
      steamdeck.user = "deck";
      Maxwell.user = "nicko";
      volta.user = "norta";
      motherbrain.user = "norta";
      tesla.user = "norta";
    };
  };
}
