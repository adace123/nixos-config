{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd-installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];
}
