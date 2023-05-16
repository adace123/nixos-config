{
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (config.home.sessionVariables) TERMINAL;
in {
  imports = [
    ./config.nix
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = true;
    # config = {}; # TODO: hyprland config
  };
}
