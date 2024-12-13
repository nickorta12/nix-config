{pkgs, ...}: let
  logidConfig = (pkgs.formats.libconfig {}).generate "logid.cfg" {
    devices = [
      {
        name = "Wireless Mouse MX Master 3";
      }
    ];
    dpi = 1200;
  };
in {
  environment.etc."logid.cfg".source = logidConfig;
  systemd = {
    packages = [pkgs.logiops];
    services.logid = {
      wantedBy = ["multi-user.target"];
      restartTriggers = [logidConfig];
    };
  };
}
