{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.shell.nushell;
  nu_script_path = "${inputs.nu_scripts}";
  custom_scripts = builtins.map (x:
    pkgs.nuenv.writeScriptBin {
      name = builtins.replaceStrings [".nu"] [""] (builtins.baseNameOf x);
      script = builtins.readFile ./scripts/${x};
    }) (builtins.attrNames (builtins.readDir ./scripts));
in
  with lib; {
    options.modules.shell.nushell.enable = mkEnableOption "nushell";

    config = mkIf cfg.enable {
      home.packages = with pkgs; [jc carapace] ++ custom_scripts;

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
          # completions
          source ${nu_script_path}/custom-completions/git/git-completions.nu
          source ${nu_script_path}/custom-completions/btm/btm-completions.nu
          source ${nu_script_path}/custom-completions/cargo/cargo-completions.nu
          source ${nu_script_path}/custom-completions/just/just-completions.nu
          source ${nu_script_path}/custom-completions/nix/nix-completions.nu
          source ${nu_script_path}/custom-completions/tealdeer/tldr-completions.nu
          source ${nu_script_path}/custom-completions/zellij/zellij-completions.nu
          source ${nu_script_path}/custom-completions/bitwarden-cli/bitwarden-cli-completions.nu

          # modules
          source ${nu_script_path}/modules/argx/argx.nu
          source ${nu_script_path}/modules/data_extraction/ultimate_extractor.nu
          source ${nu_script_path}/modules/nix/nix.nu
          source ${nu_script_path}/modules/weather/get-weather.nu

          # themes
          use ${nu_script_path}/themes/nu-themes/everforest.nu
          $env.config = ($env.config | merge {color_config: (everforest)})
        '';
      };
    };
  }
