{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.modern-unix;
in
with lib;
{
  options.adace.programs.terminal.tools.modern-unix.enable = mkEnableOption "Modern Unix tools";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      doggo
      delta
      duf
      dysk
      eva
      eza
      fd
      glow
      gum
      hyperfine
      ouch
      ripgrep
      sd
      tailspin
      viddy
    ];
  };

}
