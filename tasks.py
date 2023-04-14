import platform

from invoke import Context, Result, task


@task
def build_vm(c: Context, version: str = "22.05"):
    if platform.system() == "Darwin":
        iso_url = f"curl --fail -sL https://channels.nixos.org/nixos-{version}/latest-nixos-minimal-x86_64-linux.iso.sha256 | grep -Eo '^[0-9a-z]{{64}}'"
        iso_checksum: Result = c.run(iso_url).stdout.strip()
        c.run(
            f"packer build -var arch=x86_64 -var version={version} -var iso_checksum='{iso_checksum}' -var builder=qemu.qemu -only=qemu.qemu nixos.pkr.hcl"
        )
