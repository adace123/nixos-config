{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.kubernetes;
  copyCommand =
    if pkgs.stdenv.isDarwin
    then "pbcopy"
    else "wl-copy";
in
  with lib; {
    config = mkIf cfg.enable {
      programs.k9s = {
        enable = true;
        plugin.plugins = {
          copy_ingress_url = {
            shortCut = "Ctrl-Y";
            description = "Copy URL";
            background = true;
            scopes = ["ing"];
            command = "bash";
            args = [
              "-c"
              "kubectl get ing -n $NAMESPACE $NAME --context $CONTEXT -o jsonpath='{.spec.rules[0].host}' | tr -d \"'\" | ${copyCommand}"
            ];
          };
        };
      };
    };
  }
