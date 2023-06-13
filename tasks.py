import os
import subprocess
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Optional

from invoke import Context, task

age_key_path = Path.home() / ".config/sops/age/keys.txt"
os.environ["SOPS_AGE_KEY_FILE"] = str(age_key_path)

@task
def update_lock(c: Context, flake_input: Optional[str] = None):
    if flake_input is not None:
        cmd = f"nix flake lock --update-input {flake_input}"
    else:
        cmd = "nix flake update"
    c.run(cmd)

@task
def edit_secrets(c: Context):
    c.run("sops modules/nixos/secrets/secrets.yaml", pty=True)

@task
def get_secret(c: Context, key: str):
    c.run(f"sops --extract '[\"{key}\"]' -d modules/nixos/secrets/secrets.yaml")

@task
def install_nixos(c: Context, flake_attr: str, host: str):
    with TemporaryDirectory() as d:
        root = Path(d) / "root"
        root.mkdir(parents=True, exist_ok=True)
        root.chmod(0o755)
        host_key = root / "etc/ssh/ssh_host_ed25519_key"
        host_key.parent.mkdir(parents=True, exist_ok=True)

        (root / "boot/initrd").mkdir(parents=True, exist_ok=True)
        secrets = {
            "ssh_host_ed25519_key": "etc/ssh/ssh_host_ed25519_key",
            "luks-key": "cryptroot.key",
        }

        for sops_key, path in secrets.items():
            subprocess.run(
                [
                    "sops",
                    "--extract",
                    f'["{sops_key}"]',
                    "-d",
                    "modules/nixos/secrets/secrets.yaml",
                ],
                check=True,
                stdout=(root / path).open("w"),
            )

        luks_key = root / "cryptroot.key"
        c.run(
            f"nix run github:adace123/nixos-anywhere -- {host} --build-on-remote --debug --flake .#{flake_attr} --extra-files {root} --disk-encryption-keys /cryptroot.key {luks_key}"
        )

@task
def switch(c: Context, flake_attr: str, host: str, install_bootloader: bool = False):
    cwd = Path.cwd()
    rsync_cmd = f"rsync -a {cwd} host:/home/aaron"
    cmd = f"cd dotfiles; sudo nixos-rebuild switch --flake .#{flake_attr}"
    if install_bootloader:
        cmd = f"cd dotfiles; sudo nix-collect-garbage -d; sudo rm -rvf /boot/*; {cmd} --install-bootloader"
    c.run(f"{rsync_cmd}; ssh {host} '{cmd}'")
