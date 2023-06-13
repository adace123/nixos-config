{
  config,
  modulesPath,
  nixpkgs,
  inputs,
  system,
  ...
}: let
  overlays = [inputs.nuenv.overlays.nuenv];
  pkgs = import nixpkgs {inherit overlays system;};
in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  users.users.root.initialPassword = "nixos";

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  boot.initrd.kernelModules = ["wl"];

  environment.systemPackages = with pkgs; [
    nixFlakes
    nushell
    git
  ];
}
