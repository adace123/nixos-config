{ lib, ... }:
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/nix/default.nix") ];
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
      interval = {
        Hour = 13;
        Day = 1;
      };
    };
  };
}
