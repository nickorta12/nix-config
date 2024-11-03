nh-build:
    nh os build . -- --show-trace

nh-switch:
    nh os switch . -- --show-trace

volta-switch:
    nixos-rebuild switch --build-host root@192.168.0.78 --target-host root@192.168.0.78 --flake .#volta

alias switch := nh-switch
