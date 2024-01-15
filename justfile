set shell := ["nu", "-c"]

default:
  just --list

rebuild host:
  nixos-rebuild switch --flake '.#{{host}}'

docker:
  #!/usr/bin/env nu
  if (docker ps | detect columns | where NAMES = "nixos" | is-empty) {
    (
      docker run --name=nixos --restart=always -d  
      -e NIX_CONFIG="experimental-features = nix-command flakes" 
      -it -v $"(pwd):/nixos-config" -w /nixos-config
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

  while (true) {
    let run = gh run view $run_id --json="status,startedAt,conclusion" | from json
    match $run.status {
      "in_progress" => {
        echo $"Waiting for run ($run_id) to finish. Started ($run.startedAt | date humanize)"
        sleep 10sec
      },
      "completed" => {
        match $run.conclusion {
          "completed" | "success" => {break},
          "failed" => { error make {msg: $"Build workflow ($run_id) failed"} },
          "cancelled" => { error make {msg: $"Build workflow ($run_id) cancelled"} },
          $status => { error make {msg: $"Unexepected status for build workflow ($run_id): ($status)"} },
        }
      },
    }
  }

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
  let sops_key = pulumi stack output --show-secrets -C keys sops | jq -r '.privKey'

check:
  nix flake check

clean:
  sudo nix-collect-garbage --delete-old

ssh user host:
  #!/usr/bin/env nu
  let tmp = mktemp -t
  pulumi stack output -C keys --show-secrets {{host}} | jq -r '.privKey' | save -f $tmp
  ssh -i $tmp {{user}}@{{host}}.local
  
