{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.packages;
in
with lib;
{
  options.adace.system.packages.enable = mkEnableOption "Enable system packages";
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
