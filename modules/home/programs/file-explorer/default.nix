{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.file-explorer;
in
  with lib; {
    options.modules.file-explorer.enable = mkEnableOption "file explorer";
    config = mkIf cfg.enable {
      home.packages = [pkgs.xplr];

      home.file.".config/xplr/init.lua".text = ''
        ---@diagnostic disable
        version = "0.21.2"
        local xplr = xplr
        ---@diagnostic enable

        -- Lua search path
        local home = os.getenv("HOME")
        package.path = home
            .. "/.config/xplr/plugins/?/init.lua;"
            .. home
            .. "/.config/xplr/plugins/?.lua;"
            .. package.path

        -- XPM (init)
        local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
        local xpm_url = "https://github.com/dtomvan/xpm.xplr"

        package.path = package.path
            .. ";"
            .. xpm_path
            .. "/?.lua;"
            .. xpm_path
            .. "/?/init.lua"

        os.execute(
            string.format(
                "[ -e '%s' ] || git clone '%s' '%s'",
                xpm_path,
                xpm_url,
                xpm_path
            )
        )

        -- plugin-related
        xplr.config.modes.builtin.default.key_bindings.on_key.x = {
            help = "xpm",
            messages = {
                "PopMode",
                { SwitchModeCustom = "xpm" },
            },
        }

        require("xpm").setup({
          auto_cleanup = true,
          auto_install = true,
          plugins = {
            "dtomvan/xpm.xplr",
            "sayanarijit/map.xplr",
            "sayanarijit/command-mode.xplr",
            "sayanarijit/tri-pane.xplr",
            "prncss-xyz/icons.xplr",
            "sayanarijit/wl-clipboard.xplr",
            "sayanarijit/fzf.xplr",
            "sayanarijit/zoxide.xplr",
          }
        })

        -- initializing plugins
        require("map").setup()
        require("command-mode").setup()
        require("tri-pane").setup()
        require("icons").setup()
        require("zoxide").setup()

        -- personalized configurations
        xplr.config.general.enable_mouse = true
        xplr.config.general.show_hidden = true
        xplr.config.general.enable_recover_mode = true

      '';
    };
  }
