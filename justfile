nh-build:
    nh os build . -- --show-trace --accept-flake-config

nh-switch:
    nh os switch . -- --show-trace --accept-flake-config

# Update all inputs
update:
    nix flake update --accept-flake-config

# Update nvim
update-nvim:
    nix flake update nickvim --accept-flake-config

# Update specific flake input or inputs
update-input +inputs:
    nix flake update --accept-flake-config {{inputs}}

deploy:
    colmena apply

format:
    nix fmt --accept-flake-config

volta-switch:
    nixos-rebuild switch --build-host root@10.25.0.2 --target-host root@10.25.0.2 --flake .#volta

alias build := nh-build
alias switch := nh-switch
