{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.shell.nushell;
  nu_script_path = "${pkgs.nu_scripts}/share/nu_scripts";
in
  with lib; {
    options.modules.shell.nushell.enable = mkEnableOption "nushell";

    imports = [./scripts];

    config = mkIf cfg.enable {
      home.packages = with pkgs; [jc carapace direnv nix-direnv];

      home.file.".config/nushell" = {
        recursive = true;
        source = ./config;
      };

      programs.zoxide.enable = true;

      programs.nushell = {
        enable = true;
        package = pkgs.nushell;
        envFile.source = ./config/environment.nu;
        configFile.source = ./config/main.nu;
        extraConfig = ''
          # plugins
          register ${pkgs.nushellPlugins.query}/bin/nu_plugin_query

          # completions
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/git/git-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/btm/btm-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/cargo/cargo-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/nix/nix-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/tealdeer/tldr-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/zellij/zellij-completions.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/just/just.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/bitwarden-cli/bitwarden-cli-completions.nu *

          # modules
          use ${pkgs.nu_scripts}/share/nu_scripts/modules/kubernetes/kubernetes.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/modules/data_extraction/ultimate_extractor.nu *
          use ${pkgs.nu_scripts}/share/nu_scripts/modules/network/ssh.nu *

          # themes
          use ${pkgs.nu_scripts}/share/nu_scripts/themes/themes/everforest.nu

          let-env config = ($env.config | merge {color_config: (everforest)})
        '';
      };
    };
  }
