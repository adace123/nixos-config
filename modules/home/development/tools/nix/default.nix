{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.tools.nix;
in
with lib;
{
  options.adace.development.tools.nix.enable = mkEnableOption "Nix tools";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nh
      nurl
    ];
  };
}
