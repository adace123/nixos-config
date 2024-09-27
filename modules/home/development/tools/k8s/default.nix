{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.tools.kubernetes;
in
with lib;
{
  options.adace.development.tools.kubernetes.enable = mkEnableOption "kubernetes tools";
  imports = [ ./k9s.nix ];
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cilium-cli
      clusterctl
      cmctl
      fluxcd
      kubernetes-helm
      kind
      k8sgpt
      kubectl
      kubectx
      kustomize
      talosctl
      podman
      podman-compose
      podman-tui
      stern
      lazydocker
    ];
  };
}
