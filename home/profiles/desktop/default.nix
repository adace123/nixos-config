{lib, ...}: with lib; {
  imports = [
    ../../../modules/programs
    ../../../modules/desktop/wayland/hyprland
  ];
}
