{config, ...}: {
  imports = [
    ../common
    ../../desktop
    ../../terminal
  ];

  desktop.hyprland.enable = true;
}
