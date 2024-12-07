{pkgs, ...}: {
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-7.0.20"
  ];

  environment.systemPackages = [pkgs.vintagestory];

  # systemd.services.vintagestory = {
  #   description = "Vintage Story Server";
  #   wantedBy = ["multi-user.target"];
  #   after = ["network.target"];
  #
  #   serviceConfig = {
  #     ExecStart = "${pkgs.vintagestory}/bin/vintagestory-server";
  #   };
  # };
}
