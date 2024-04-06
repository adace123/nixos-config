{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.sound;
  bluetoothCfg = config.modules.bluetooth;
in
  with lib; {
    options.modules.sound.enable = mkEnableOption "Sound";

    config = mkIf cfg.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber = mkIf bluetoothCfg.enable {
          enable = true;
          configPackages = [
            (pkgs.writeTextDir "wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
              bluez_monitor.properties = {
              	["bluez5.enable-sbc-xq"] = true,
              	["bluez5.enable-msbc"] = true,
              	["bluez5.enable-hw-volume"] = true,
              	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
              }
            '')
          ];
        };
      };
    };
  }
