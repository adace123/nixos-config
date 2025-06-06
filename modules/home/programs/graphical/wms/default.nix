{ lib, ... }:
with lib;
{
  options.adace.home.desktop = {
    wallpaper = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Desktop wallpaper";
    };
    monitor = {
      resolution = mkOption {
        type = types.str;
        description = "Monitor resolution";
      };
      output = mkOption {
        type = types.str;
        description = "Monitor output";
      };
    };
  };
}
