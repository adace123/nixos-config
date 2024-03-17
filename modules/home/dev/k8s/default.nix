{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.kubernetes;
in
  with lib; {
    options.modules.dev.kubernetes.enable = mkEnableOption "kubernetes tools";
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        cilium-cli
        clusterctl
        fluxcd
        kubernetes-helm
        kind
        k9s
        krew
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
