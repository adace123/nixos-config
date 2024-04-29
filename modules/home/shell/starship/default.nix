{
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.starship;
in
  with lib; {
    options.modules.shell.starship.enable = mkEnableOption "starship prompt";
    config = mkIf cfg.enable {
      programs.starship = {
        enable = true;
        settings = {
          format = lib.concatStrings [
            "$os"
            "$directory"
            "$git_branch$git_status"
            "$python"
            "$nix_shell"
            "$time"
            "$line_break"
            "$character"
          ];

          right_format = "$kubernetes";

          add_newline = true;

          os = {
            disabled = false;
            symbols = {
              Macos = " ";
            };
          };

          username = {
            show_always = true;
            format = "[ $user]($style)";
          };

          hostname = {
            ssh_symbol = "";
            ssh_only = false;
            disabled = false;
          };

          directory = {
            truncation_length = 3;
          };

          directory.substitutions = {
            "Documents" = " ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };

          time = {
            disabled = false;
            time_format = "%I:%M %p";
          };

          character = {
            success_symbol = "[λ](bold purple)";
            error_symbol = "[](bold red)";
          };

          kubernetes = {
            disabled = false;
            format = "[$symbol$context \($namespace\)]($style)";
          };

          python = {
            format = "[$symbol$version]($style)";
            symbol = " ";
          };

          nix_shell = {
            format = " [$symbol\($name\)]($style) ";
          };
        };
      };
    };
  }
