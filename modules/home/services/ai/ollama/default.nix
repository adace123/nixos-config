{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.services.ai.ollama;
  ollamaPackage = pkgs.ollama.override {
    inherit (cfg) acceleration;
  };
in
with lib;
{
  options.adace.services.ai.ollama = {
    enable = mkEnableOption "Enable Ollama service";
    models = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ "llama3.2" ];
    };

    acceleration = lib.mkOption {
      type = types.nullOr (
        types.enum [
          "rocm"
          "cuda"
        ]
      );
      default = null;
      description = ''
        Specifies the interface to use for hardware acceleration.
        - `rocm`: supported by modern AMD GPUs
        - `cuda`: supported by modern NVIDIA GPUs
      '';
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = [ ollamaPackage ];
      sops.secrets.google-api-key = { };
    }
    (lib.mkIf pkgs.stdenv.isLinux {
      systemd.user.services.ollama = {
        Unit = {
          Description = "Server for local large language models";
          After = [ "network.target" ];
        };

        Service = {
          ExecStart = "${lib.getExe ollamaPackage} serve";
          Environment = [
            "OLLAMA_HOST=${cfg.listenAddress}"
          ];
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    })

    (lib.mkIf pkgs.stdenv.isDarwin {
      launchd.agents.ollama = {
        enable = true;
        config = {
          ProgramArguments = [
            "${lib.getExe ollamaPackage}"
            "serve"
          ];
          EnvironmentVariables.OLLAMA_HOST = "${cfg.listenAddress}";
          ProcessType = "Adaptive";
          RunAtLoad = true;
          StandardOutPath = "${config.xdg.stateHome}/ollama/ollama.log";
          StandardErrorPath = "${config.xdg.stateHome}/ollama/ollama.log";
        };
      };
    })
  ]);
}
