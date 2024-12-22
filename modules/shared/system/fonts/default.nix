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
      default =
        with pkgs;
        [
          material-symbols
          roboto
          font-awesome
          fira-code-symbols
          source-code-pro
        ]
        ++ (with pkgs.nerd-fonts; [
          fira-code
          geist-mono
          jetbrains-mino
        ]);
    };
  };

  config = mkIf cfg.enable {
    fonts.packages = cfg.packages;
  };
}
