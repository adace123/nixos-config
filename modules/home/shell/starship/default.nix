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
            "[░▒▓](#f5c2e7)"
            "$username"
            "$hostname"
            "[](bg:#f38ba8 fg:#f5c2e7)"
            "$directory"
            "[](fg:#f38ba8 bg:#eb7c92)"
            "$git_branch"
            "$git_status"
            "[](fg:#eb7c92 bg:#e6657f)"
            "[](fg:#e6657f bg:#e05a75)"
            "$time"
            "[](fg:#e05a75)"
            "\n$character"
          ];

          add_newline = true;

          username = {
            show_always = true;
            style_user = "bg:#f5c2e7 fg:#11111b";
            style_root = "bg:#f5c2e7 fg:#11111b";
            format = "[ $user]($style)";
          };

          hostname = {
            ssh_symbol = "";
            style = "bg:#f5c2e7 fg:#11111b";
            format = "[@$hostname]($style)";
            ssh_only = false;
            disabled = false;
          };

          directory = {
            style = "bg:#f38ba8 fg:#11111b";
            format = "[ $path ]($style)";
            truncation_length = 3;
          };

          directory.substitutions = {
            "Documents" = " ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };

          git_branch = {
            symbol = "";
            style = "bg:#eb7c92 fg:#11111b";
            format = "[ $symbol $branch ]($style)";
          };

          git_status = {
            style = "bg:#eb7c92 fg:#11111b";
            format = "[$all_status$ahead_behind ]($style)";
          };

          time = {
            disabled = false;
            time_format = "%I:%M %p";
            style = "bg:#e05a75 fg:#11111b";
            format = "[ $time ]($style)";
          };

          character = {
            success_symbol = "[λ](bold purple)";
            error_symbol = "[](bold red)";
          };
        };
      };
    };
  }
