nh-build:
    nh os build

nh-switch:
    nh os switch

volta-switch:
    nixos-rebuild switch --build-host root@192.168.0.78 --target-host root@192.168.0.78 --flake .#volta
