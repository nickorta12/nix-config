{pkgs, ...}: let
  logidConfig = (pkgs.formats.libconfig {}).generate "logid.cfg" {
    devices = [
      {
        name = "MX Master 3S";
        dpi = 1200;
      }
    ];
  };
in {
  # services.udev.packages = [pkgs.logitech-udev-rules];
  environment.etc."logid.cfg".source = ./logid.cfg;
  systemd = {
    packages = [pkgs.logiops];
    services.logid = {
      wantedBy = ["multi-user.target"];
      restartTriggers = [logidConfig];
    };
  };
}
