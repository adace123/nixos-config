{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in
  with lib; {
    imports = [
      inputs.hypridle.homeManagerModules.default
    ];
    config = mkIf cfg.enable {
      services.hypridle = {
        enable = true;
        beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
        lockCmd = lib.getExe config.programs.hyprlock.package;

        listeners = [
          {
            onTimeout = "${getExe config.programs.hyprlock.package}";
            timeout = 600;
          }
          {
            timeout = 900;
            onTimeout = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
            onResume = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
          }
          {
            timeout = 1200;
            onTimeout = suspendScript.outPath;
          }
        ];
      };
    };
  }
