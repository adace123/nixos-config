{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.fonts;
in
with lib;
{
  options.adace.system.fonts = {
    enable = mkEnableOption "Enable system fonts";
    packages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        material-symbols
        roboto
        (nerdfonts.override {
          fonts = [
            "FiraCode"
            "JetBrainsMono"
            "GeistMono"
          ];
        })
        font-awesome
        fira-code-symbols
        source-code-pro
      ];
    };
  };

  config = mkIf cfg.enable {
    fonts.packages = cfg.packages;
  };
}
