{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.lock;
in {
  options.modules.desktop.lock.enable = mkEnableOption "Enable gtklock";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gtklock
      gtklock-powerbar-module
      (catppuccin-gtk.override {
        accents = ["mauve"];
        size = "compact";
        variant = "mocha";
      })
    ];

    xdg.configFile."gtklock/config.ini".text = ''
      [main]
      gtk-theme = Catppuccin-Mocha-Compact-Mauve-Dark
      modules = ${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so
    '';
  };
}
