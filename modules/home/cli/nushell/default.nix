{
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.nushell;
in
  with lib; {
    options.modules.shell.nushell.enable = mkEnableOption "nushell";

    config = mkIf cfg.enable {
      programs.nushell = {
        enable = true;
        configFile.source = ./config.nu;
        # envFile.source = ./env.nu;
        shellAliases = {
          cat = "bat";
          bt = "bluetoothctl";
          htop = "btm --fahrenheit";
          grep = "rg";
          ll = "ls -la";
          sc = "systemctl";
          jc = "journalctl";
          tree = "exa -T --icons";
          rm = "rm -i";
          ts = "tailscale";
          k = "kubectl";
        };
        extraConfig = with config.colorScheme.colors; ''
          let theme = {
            separator: ${base03}
            leading_trailing_space_bg: ${base04}
            header: ${base0B}
            date: ${base0E}
            filesize: ${base0D}
            row_index: ${base0C}
            bool: ${base08}
            int: ${base0B}
            duration: ${base08}
            range: ${base08}
            float: ${base08}
            string: ${base04}
            nothing: ${base08}
            binary: ${base08}
            cellpath: ${base08}
            hints: gray
            shape_garbage: { fg: ${base07} bg: ${base08} attr: b}
            shape_bool: ${base0D}
            shape_int: { fg: ${base0E} attr: b}
            shape_float: { fg: ${base0E} attr: b}
            shape_range: { fg: ${base0A} attr: b}
            shape_internalcall: { fg: ${base0C} attr: b}
            shape_external: ${base0C}
            shape_externalarg: { fg: ${base0B} attr: b}
            shape_literal: ${base0D}
            shape_operator: ${base0A}
            shape_signature: { fg: ${base0B} attr: b}
            shape_string: ${base0B}
            shape_filepath: ${base0D}
            shape_globpattern: { fg: ${base0D} attr: b}
            shape_variable: ${base0E}
            shape_flag: { fg: ${base0D} attr: b}
            shape_custom: {attr: b}
          }

          let-env config = ($env.config | upsert color_config $theme)
        '';
      };
    };
  }
