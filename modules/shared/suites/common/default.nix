{
  config,
  lib,
  ...
}:
let
  cfg = config.adace.suites.common;
in
with lib;
{
  imports = snowfall.fs.get-default-nix-files-recursive ../../system;
  options.adace.suites.common.enable = mkEnableOption "Enable common configuration for all platforms";
  config = mkIf cfg.enable {
    adace.system = {
      fonts.enable = true;
      nix.enable = true;
      packages.enable = true;
    };
  };
}
