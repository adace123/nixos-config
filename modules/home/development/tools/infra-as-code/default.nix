{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.development.tools.iac;
in
with lib;
{
  options.adace.development.tools.iac.enable = mkEnableOption "Enable IAC tools";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # IaC
      # pulumi
      terraform
    ];
  };
}
