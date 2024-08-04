{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.nix;
in
  with lib; {
    options.modules.dev.nix.enable = mkEnableOption "nix dev packages";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        nh
        nix-prefetch-git
        nix-prefetch-github
      ];
    };
  }
