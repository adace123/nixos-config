{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.programs.terminal.tools.aichat;
in
with lib;
with lib.adace;
{
  options.adace.programs.terminal.tools.aichat.enable = mkEnableOption "aichat";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.aichat ];
    xdg.configFile."aichat/config.yaml".text = builtins.toJSON {
      highlight = true;
      keybindings = "vi";
      model = "ollama:llama3.2:1b";
      clients = [
        {
          type = "ollama";
          api_base = "http://localhost:11434";
          models = [ { name = "llama:3.2:1b"; } ];
        }
        {
          type = "gemini";
          models = [ { name = "gemini-1.5-flash-latest"; } ];
        }
      ];
    };

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
