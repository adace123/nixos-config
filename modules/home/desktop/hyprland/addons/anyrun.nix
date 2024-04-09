{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.addons;
in
  with lib; {
    imports = [
      inputs.anyrun.homeManagerModules.default
    ];

    config = mkIf cfg.enable {
      home.sessionVariables = {
        ANYRUN_STDIN_PLUGIN_PATH = "${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so";
      };

      programs.nushell.extraEnv = ''
        $env.ANYRUN_STDIN_PLUGIN_PATH = ${inputs.anyrun.packages.${pkgs.system}.stdin}/lib/libstdin.so
      '';

      programs.anyrun = {
        enable = true;
        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications # search applications
            shell # run shell commands
            randr # configure display (only Hyprland)
            stdin # dmenu
          ];
          x.fraction = 0.5;
          y.fraction = 0.2;
          hideIcons = false;
          hidePluginInfo = true;
          closeOnClick = true;
          showResultsImmediately = true;
        };
        extraCss = ''
          @define-color bg-col  rgba(30, 30, 46, 0.7);
          @define-color bg-col-light rgba(150, 220, 235, 0.7);
          @define-color border-col rgba(30, 30, 46, 0.7);
          @define-color selected-col rgba(150, 205, 251, 0.7);
          @define-color fg-col #D9E0EE;
          @define-color fg-col2 #F28FAD;

          * {
            transition: 200ms ease;
            font-family: "JetBrainsMono Nerd Font";
            font-size: 1.3rem;
          }

          #window {
            background: transparent;
          }

          #plugin,
          #main {
            border: 3px solid @border-col;
            color: @fg-col;
            background-color: @bg-col;
          }
          /* anyrun's input window - Text */
          #entry {
            color: @fg-col;
            background-color: @bg-col;
          }

          /* anyrun's ouput matches entries - Base */
          #match {
            color: @fg-col;
            background: @bg-col;
          }

          /* anyrun's selected entry - Red */
          #match:selected {
            color: @fg-col2;
            background: @selected-col;
          }

          #match {
            padding: 3px;
            border-radius: 16px;
          }

          #entry, #plugin:hover {
            border-radius: 16px;
          }

          box#main {
            background: rgba(30, 30, 46, 0.7);
            border: 1px solid @border-col;
            border-radius: 15px;
            padding: 5px;
          }
        '';
      };
    };
  }
