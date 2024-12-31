nh-build:
    nh os build . -- --show-trace --accept-flake-config

nh-switch:
    nh os switch . -- --show-trace --accept-flake-config

update:
    nix flake update --accept-flake-config

update-nvim:
    nix flake update nickvim

deploy:
    colmena apply

volta-switch:
    nixos-rebuild switch --build-host root@10.25.0.2 --target-host root@10.25.0.2 --flake .#volta

alias build := nh-build
alias switch := nh-switch
