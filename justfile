export NIX_CONFIG := "experimental-features = nix-command flakes"
export NIXPKGS_ALLOW_UNFREE := "1"
export SOPS_AGE_KEY_FILE := "~/.config/sops/age/keys.txt"

default:
  just --list

install host:
  export NIXOS_INSTALL_MODE=1
  nix run '.#nixosConfigurations.{{host}}.config.system.build.system-install' -- --generate_luks_key

rebuild host:
  nixos-rebuild switch --flake '.#{{host}}'

vm:
  nix run .#vm

iso flake:
  nix run github:nix-community/nixos-generators -- --format install-iso --flake '.#{{flake}}'

build host:
  nix build '.#nixosConfigurations.{{host}}.config.system.build.{{host}}'

check:
  nix flake check

infra:
  nix run .#infra

clean:
  sudo nix-collect-garbage --delete-old
