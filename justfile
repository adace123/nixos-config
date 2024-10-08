set shell := ["nu", "-c"]

ssh_opts := "-o ConnectTimeout=5 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

default:
    just --list

[linux]
rebuild host:
    nixos-rebuild switch --flake '.#{{ host }}'

[macos]
rebuild host:
    #!/bin/bash
    nix run nix-darwin -- switch --flake .#{{ host }}

docker:
    #!/usr/bin/env nu
    if (docker ps | detect columns | where NAMES =~ "nixos" | is-empty) {
      (
        docker run --name=nixos --restart=always -d  
        -e NIX_CONFIG="
          experimental-features = nix-command flakes
          filter-syscalls = false
          extra-platforms = aarch64-linux
        "
        --network=host -it
        -v $"(pwd):/nixos-config" 
        -w /nixos-config nixos/nix
      )
      docker exec -it nixos git config --global --add safe.directory /nixos-config
    }

[private]
bootstrap-build-remote:
    #!/usr/bin/env nu
    use std assert error
    gh workflow run build.yaml
    # wait for run to start
    sleep 10sec
    let run_id = gh run list --workflow=build.yaml --json=databaseId | jq '.[0].databaseId'

    try {
      gh run watch --exit-status $run_id
    } catch {
      gh run view $run_id --log-failed
      exit 1
    }

    if ("nixos.iso" | path exists) {
      rm --force nixos.iso
      echo "Removed old iso file"
    }
    echo "Downloading new iso file"
    gh run download -n nixos.iso $run_id

[macos]
[private]
bootstrap-build-local: docker
    docker exec -it nixos nix build ".#nixosConfigurations.iso.config.system.build.isoImage"
    let iso_path = $"(docker exec -it nixos readlink ./result)/iso/nixos.iso"
    docker cp $"nixos:($iso_path)" ./nixos.iso

[linux]
[private]
bootstrap-build-local:
    nix build ".#nixosConfigurations.iso.config.system.build.isoImage"

bootstrap-build mode="remote":
    #!/usr/bin/env nu
    if ("{{ mode }}" == "remote") {
      just bootstrap-build-remote
    } else {
      just bootstrap-build-local 
    }

[macos]
nix-install:
    #!/bin/bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

[macos]
bootstrap-write device:
    sudo sh -c "dd if=./nixos.iso of={{ device }} bs=10M"
    sudo diskutil eject {{ device }}

[linux]
bootstrap-write:
    nix run "nixpkgs#bootiso" -- ./nixos.iso

bootstrap device build-mode="remote":
    just bootstrap-build {{ build-mode }}
    just bootstrap-write {{ device }}

copy host src dest:
    #!/usr/bin/env nu
    let privkey_path = mktemp -t
    let ssh_config = pulumi stack output -s dev --show-secrets -C keys {{ host }} | from json
    $ssh_config | get privKey | save -f $privkey_path

    echo $"Copying {{ src }} to {{ dest }} on ($ssh_config.url)"
    (
      rsync -rlv -FF
      -e $"ssh -i ($privkey_path) {{ ssh_opts }}"
      --chmod 755
      --filter=':- .gitignore'
      {{ src }} $"($ssh_config.url):{{ dest }}"
    )

nixos-install host config:
    #!/usr/bin/env nu
    let root_tmpdir = mktemp -d

    let iso_tmp = mktemp -t
    let luks_tmp = mktemp -t
    mkdir $"($root_tmpdir)/etc/ssh"
    mkdir $"($root_tmpdir)/boot/initrd"

    chmod -R 0755 $root_tmpdir

    # write iso SSH key to temp file
    just get-ssh-key iso | save -f $iso_tmp

    # write disk decryption key to temp file
    just get-host-secret luks-password | save -f $"($root_tmpdir)/secret.key"
    # write sops secret decryption key to temp file
    pulumi stack output --show-secrets -s dev -C keys sops | from json | get privKey | save -f $"($root_tmpdir)/etc/ssh/sops-nix"

    let ssh_config = pulumi stack output -s dev --show-secrets -C keys {{ host }} | from json

    with-env [SHELL "/bin/sh"] { # https://github.com/nix-community/nixos-anywhere/issues/280
      (
        nix run github:nix-community/nixos-anywhere --
        --build-on-remote
        --flake .#{{ config }}
        --disk-encryption-keys /tmp/secret.key $"($root_tmpdir)/secret.key"
        --extra-files $root_tmpdir
        -i $iso_tmp
        $ssh_config.url
      )
    }

get-ssh-key host:
    #!/usr/bin/env nu
    let key = pulumi stack output -s dev --show-secrets -C keys {{ host }} | from json | get privKey
    echo $key

get-host-secret key host="common":
    #!/usr/bin/env nu
    let yaml_path = if ("{{ host }}" == "common") {
      "modules/nixos/secrets.yaml"
    } else {
      "modules/home/secrets.yaml"
    }

    let sops_age_key = pulumi stack output -s dev --show-secrets -C keys age | from json | get privKey
    with-env [SOPS_AGE_KEY $sops_age_key] {
      sops -d $yaml_path | from yaml | get {{ key }}
    }

edit-host-secrets type="system":
    #!/usr/bin/env nu
    let yaml_path = if ("{{ type }}" == "system") {
      "modules/nixos/secrets.yaml"
    } else {
      "modules/home/secrets.yaml"
    }
    $env.SOPS_AGE_KEY = (pulumi stack output -s dev --show-secrets -C keys age | from json | get privKey)
    sops $yaml_path

[linux]
check:
    nix flake check --all-systems

[macos]
check: docker
    docker exec -it nixos nix flake check --all-systems

clean:
    sudo nix-collect-garbage --delete-old

ssh host *args:
    #!/usr/bin/env nu
    let tmp = mktemp -t
    let host_config = pulumi stack output -s dev -C keys --show-secrets {{ host }} | from json
    $host_config | get privKey | save -f $tmp
    echo $"Creating SSH connection to ($host_config.url)"
    ssh -i $tmp {{ ssh_opts }} ($host_config.url) {{ args }}

rotate-keys:
    pulumi destroy -y -C keys
    pulumi up -y -C keys
