{config, ...}: {
  imports = [
    ../common
    ../../desktop
    ../../shell
  ];

  desktop.hyprland.enable = true;
}
