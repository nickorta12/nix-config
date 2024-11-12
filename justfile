nh-build:
    nh os build . -- --show-trace

nh-switch:
    nh os switch . -- --show-trace

update:
    nix flake update

deploy:
    colmena apply

volta-switch:
    nixos-rebuild switch --build-host root@10.25.0.2 --target-host root@10.25.0.2 --flake .#volta

alias build := nh-build
alias switch := nh-switch
