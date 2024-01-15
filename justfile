set shell := ["nu", "-c"]

default:
  just --list

rebuild host:
  nixos-rebuild switch --flake '.#{{host}}'

docker:
  #!/usr/bin/env nu
  if (docker ps | detect columns | where NAMES =~ "nixos" | is-empty) {
    (
      docker run --name=nixos --restart=always -d  
      -e NIX_CONFIG="experimental-features = nix-command flakes" 
      -it -v $"(pwd):/nixos-config" -w /nixos-config nixos/nix
    )
  }

[private]
bootstrap-build-remote:
  #!/usr/bin/env nu
  use std assert error
  gh workflow run build.yaml
  # wait for run to start
  sleep 10sec
  let run_id = gh run list --workflow=build.yaml --json=databaseId | jq '.[0].databaseId'

  gh run watch --exit-status $run_id

  if ("nixos.iso" | path exists) {
    echo "Removing old iso file"
    rm --force nixos.iso
  }
  gh run download -n nixos.iso $run_id

[private]
[macos]
bootstrap-build-local: docker
    docker exec -it nixos nix build ".#nixosConfigurations.iso.config.system.build.isoImage"
    let iso_path = $"(docker exec -it nixos readlink ./result)/iso/nixos.iso"
    docker cp $"nixos:($iso_path)" ./nixos.iso

[private]
[linux]
bootstrap-build-local:
  nix build ".#nixosConfigurations.iso.config.system.build.isoImage"

bootstrap-build mode="local":
  #!/usr/bin/env nu
  if ("{{mode}}" == "remote") {
    just bootstrap-build-remote
  } else {
    just bootstrap-build-local 
  }

[macos]
bootstrap-write device:
  sudo sh -c "dd if=./nixos.iso of={{device}} bs=4M | pv | dd of={{device}} bs=4M"

[linux]
bootstrap-write:
  nix run "nixpkgs#bootiso" -- ./nixos.iso

bootstrap build-mode="local": (bootstrap-build build-mode)
  bootstrap-write

install host:
  #!/usr/bin/env nu
  let sops_age_key = pulumi stack output --show-secrets -C keys age | jq -r '.privKey'
  with-env [SOPS_AGE_KEY $sops_age_key] {
    (
      nix run github:nix-community/nixos-anywhere -- 
      --flake .#{{host}} root@{{host}}.local 
      --disk-encryption-keys /cryptroot.key 
    )
  }

get-secret key host="":
  #!/usr/bin/env nu
  let yaml_path = if ("{{host}}" == "") {
    "hosts/secrets.yaml"
  } else {
    "hosts/{{host}}/secrets.yaml"
  }

  let sops_age_key = pulumi stack output --show-secrets -C keys age | jq -r '.privKey'
  with-env [SOPS_AGE_KEY $sops_age_key] {
    sops -d $yaml_path | yq '.{{key}}'
  }

[linux]
check:
  nix flake check

[macos]
check: docker
  docker exec -it nixos nix flake check

clean:
  sudo nix-collect-garbage --delete-old

ssh user host:
  #!/usr/bin/env nu
  let tmp = mktemp -t
  pulumi stack output -C keys --show-secrets {{host}} | jq -r '.privKey' | save -f $tmp
  ssh -i $tmp {{user}}@{{host}}.local
  
rotate-keys:
  pulumi destroy -y -C keys
  pulumi up -y -C keys
