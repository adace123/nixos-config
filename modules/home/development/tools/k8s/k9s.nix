{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.development.tools.kubernetes;
  copyCommand = if pkgs.stdenv.isDarwin then "pbcopy" else "wl-copy";
in
with lib;
{
  config = mkIf cfg.enable {
    programs.k9s = {
      enable = true;
      settings.k9s = {
        ui = {
          logoless = true;
        };
        logger.textWrap = true;
        skipLatestRevCheck = true;
      };
      plugin.plugins = {
        copy-ingress-url = {
          shortCut = "Ctrl-Y";
          description = "Copy URL";
          background = true;
          scopes = [ "ing" ];
          command = "bash";
          args = [
            "-c"
            "kubectl get ing -n $NAMESPACE $NAME --context $CONTEXT -o jsonpath='{.spec.rules[0].host}' | tr -d \"'\" | ${copyCommand}"
          ];
        };
        # https://github.com/derailed/k9s/blob/master/plugins/cert-manager.yaml
        check-cert-status = {
          shortCut = "Shift-S";
          confirm = false;
          background = false;
          description = "Certificate status";
          scopes = [ "certificate" ];
          command = "bash";
          args = [
            "-c"
            "cmctl status certificate --context $CONTEXT -n $NAMESPACE $NAME | less"
          ];
        };
        # https://github.com/derailed/k9s/blob/master/plugins/debug-container.yaml
        debug-container = {
          shortCut = "Shift-D";
          description = "Add debug container";
          dangerous = true;
          scopes = [ "containers" ];
          command = "bash";
          background = false;
          confirm = true;
          args = [
            "-c"
            "kubectl debug -it --context $CONTEXT -n=$NAMESPACE $POD --target=$NAME --image=nicolaka/netshoot:v0.12 --share-processes -- bash"
          ];
        };
        # https://github.com/derailed/k9s/blob/master/plugins/helm-default-values.yaml
        helm-default-values = {
          shortCut = "Shift-V";
          description = "Default Values";
          scopes = [ "helm" ];
          background = false;
          command = "sh";
          args = [
            "-c"
            ''
              revision=$(helm history -n $NAMESPACE --kube-context $CONTEXT $COL-NAME | grep deployed | cut -d$'\t' -f1 | tr -d ' \t');
              kubectl get secrets --context $CONTEXT -n $NAMESPACE \
              sh.helm.release.v1.$COL-NAME.v$revision -o yaml \
              | yq e '.data.release' -
              | base64 -d
              | base64 -d
              | gunzip
              | jq -r '.chart.values'
              | yq -P
              | less -K
            ''
          ];
        };
        # https://github.com/derailed/k9s/blob/master/plugins/helm-values.yaml
        helm-values = {
          shortCut = "v";
          description = "Values";
          scopes = [ "helm" ];
          background = false;
          command = "sh";
          args = [
            "-c"
            "helm get values $COL-NAME -n $NAMESPACE --kube-context $CONTEXT | less -K"
          ];
        };
        # https://github.com/derailed/k9s/blob/master/plugins/flux.yaml
        flux-reconcile-kustomization = {
          shortCut = "Shift-R";
          description = "Flux reconcile";
          scopes = [ "kustomization" ];
          command = "bash";
          args = [
            "-c"
            "flux reconcile kustomization -n $NAMESPACE $NAME | less -K"
          ];
        };
      };
    };
  };
}
