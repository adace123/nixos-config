{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.aichat;
  toYAML =
    config:
    builtins.readFile (
      pkgs.runCommand "to-yaml" { } ''
        ${pkgs.yq}/bin/yq -y . ${pkgs.writeText "to-json" (builtins.toJSON config)}  > $out
      ''
    );
in
with lib;
{
  options.adace.programs.terminal.tools.aichat.enable = mkEnableOption "aichat";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.aichat ];
    xdg.configFile."aichat/config.yaml".text = toYAML {
      highlight = true;
      keybindings = "vi";
      model = "ollama:llama3.1";
      clients = [
        {
          type = "ollama";
          api_base = "http://localhost:11434";
          models = [ { name = "gemma2"; } ];
        }
        {
          type = "gemini";
          models = [ { name = "gemini-1.5-flash-latest"; } ];
        }
      ];
    };

    home.file.".config/aichat/roles.yaml".text = toYAML [
      {
        name = "nushell";
        prompt = ''
          Act as a Nushell expert.
          Answer only with code.
          Do not write any explanations.
        '';
      }
    ];

    programs.nushell.extraConfig = ''
      def _aichat_nushell [] {
        let _prev = (commandline)
          if ($_prev != "") {
            print '⌛'
            commandline edit -r (aichat -e $_prev)
          }
      }

      $env.config.keybindings = ($env.config.keybindings | append {
          name: aichat_integration
          modifier: control
          keycode: char_q
          mode: [emacs, vi_insert, vi_normal]
          event: {
            send: executehostcommand,
            cmd: "_aichat_nushell"
          }
        }
      )
    '';
  };
}
