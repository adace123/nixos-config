{
  lib,
  config,
  ...
}: let
  cfg = config.sys.sound;
  bluetoothCfg = config.sys.bluetooth;
in
  with lib; {
    options.sys.sound.enable = mkEnableOption "Sound";

    config = mkIf cfg.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      environment.etc = mkIf bluetoothCfg.enable {
        "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
          bluez_monitor.properties = {
          	["bluez5.enable-sbc-xq"] = true,
          	["bluez5.enable-msbc"] = true,
          	["bluez5.enable-hw-volume"] = true,
          	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        '';
      };
    };
  }
