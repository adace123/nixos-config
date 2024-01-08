set shell := ["nu", "-c"]

default:
  just --list

rebuild host:
  nixos-rebuild switch --flake '.#{{host}}'

docker:
  #!/usr/local/bin/nu
  if (docker ps | detect columns | where NAMES = "nixos" | is-empty) {
    (
      docker run --name=nixos --restart=always -d  
      -e NIX_CONFIG="experimental-features = nix-command flakes" 
      -it -v $"(pwd):/nixos-config" -w /nixos-config
    )
  }

[macos]
bootstrap-build: docker
  #!/usr/local/bin/nu
  docker exec -it nixos nix build ".#nixosConfigurations.iso.config.system.build.isoImage"
  let iso_path = $"(docker exec -it nixos readlink ./result)/iso/nixos.iso"
  docker cp $"nixos:($iso_path)" ./nixos.iso

[linux]
bootstrap-build:
  nix build ".#nixosConfigurations.iso.config.system.build.isoImage"

[macos]
bootstrap-write device:
  sudo dd if=./nixos.iso of={{device}} status=progress bs=10m

[linux]
bootstrap-write:
  nix run "nixpkgs#bootiso" -- ./nixos.iso

install host:
  let sops_key = pulumi stack output --show-secrets -C keys sops | jq -r '.privKey'

check:
  nix flake check

clean:
  sudo nix-collect-garbage --delete-old
