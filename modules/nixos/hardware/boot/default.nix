{
  config,
  lib,
  options,
  ...
}:
with lib; let
  inherit (config.system.boot) configLimit;
in {
  options.system.boot.configLimit = mkOption {
    default = 10;
    description = "Boot configuration limit";
    type = types.int;
  };

  config = {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        grub = {
          enable = true;
          version = 2;
          efiSupport = true;
          device = "nodev";
          configurationLimit = configLimit;
        };
      };
    };
  };
}
