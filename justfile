export NIX_CONFIG := "experimental-features = nix-command flakes"

default:
  just --list

install host:
  nix run '.#nixosConfigurations.{{host}}.config.system.build.install'

vm:
  nix run .#vm

iso flake:
  nix run github:nix-community/nixos-generators -- --format install-iso --flake '.#{{flake}}'

build host:
  nix build '.#nixosConfigurations.{{host}}.config.system.build.{{host}}'

