{ config, lib, ... }:
let
  cfg = config.adace.system.nix;
in
with lib;
{
  config = mkIf cfg.enable {
    nix = {
      gc = {
        interval = {
          Hour = 12;
          Minute = 0;
          Day = 1;
        };
        user = "aaron";
      };

      optimise = {
        user = "aaron";
        interval = {
          Hour = 13;
          Day = 1;
        };
      };
    };
  };
}
