{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.suites.common;
in
with lib;
{
  options.adace.suites.common.enable = mkEnableOption "Enable common configuration for all platforms";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      curl
      fzf
      git
      jq
      just
      lsof
      nushell
      openssl
      pkg-config
      rsync
      sysz
      tldr
      vim
      unzip
      yq
    ];
  };
}
