# TODO: This will need to be refactored once null-ls is deprecated
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.neovim;
  mkLspServer = server: let
    cmd = [server.command] ++ server.cmdArgs;
    cmdString = builtins.concatStringsSep ", " (map (s: "\"${s}\"") cmd);
  in {
    name = ".config/astronvim/lua/user/lsp/config/${server.name}.lua";
    value = {
      text = ''
        return {
          cmd = { ${cmdString} },
          ${server.extraConfig}
        }
      '';
    };
  };
  formattedLspServerNames = builtins.concatStringsSep ", " (map (server: "\n \"${server.name}\"") servers);
  servers = builtins.filter (l: l.type == "lsp") cfg.languageSupport;
  formatters = builtins.filter (l: l.type == "formatting") cfg.languageSupport;
  diagnostics = builtins.filter (l: l.type == "diagnostics") cfg.languageSupport;
  null-ls-builder = builtins.map (x: ''
    null_ls.builtins.${x.type}.${x.name}.with({ command = "${x.command}" })
  '');
  null-ls-settings = builtins.concatStringsSep ", " (
    (null-ls-builder formatters)
    ++ (null-ls-builder diagnostics)
  );

  defaultLsps = [
    {
      name = "nixd";
      command = "${pkgs.nixd}/bin/nixd";
      type = "lsp";
    }
    {
      name = "lua_ls";
      command = "${pkgs.lua-language-server}/bin/lua-language-server";
      type = "lsp";
    }
    {
      name = "yamlls";
      command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
      type = "lsp";
    }
    {
      name = "taplo";
      command = "${pkgs.taplo-lsp}/bin/taplo-lsp";
      type = "lsp";
    }
  ];

  defaultFormatters = [
    {
      name = "alejandra";
      command = "${pkgs.alejandra}/bin/alejandra";
      type = "formatting";
    }
    {
      name = "stylua";
      command = "${pkgs.stylua}/bin/stylua";
      type = "formatting";
    }
    {
      name = "yamlfmt";
      command = "${pkgs.yamlfmt}/bin/yamlfmt";
      type = "formatting";
    }
  ];

  defaultDiagnostics = [
    {
      name = "selene";
      command = "${pkgs.selene}/bin/selene";
      type = "diagnostics";
    }
    {
      name = "yamllint";
      command = "${pkgs.yamllint}/bin/yamllint";
      type = "diagnostics";
    }
  ];

  defaultSources = defaultLsps ++ defaultFormatters ++ defaultDiagnostics;
in
  with lib; {
    options.modules.editors.neovim.languageSupport = with types;
      mkOption {
        description = "list of lsp servers to be managed by mason";
        type = listOf (submodule {
          options = {
            name = mkOption {type = str;};
            command = mkOption {type = str;};
            cmdArgs = mkOption {
              type = listOf str;
              default = [];
            };
            type = mkOption {type = enum ["lsp" "diagnostics" "formatting"];};
            extraConfig = mkOption {
              type = str;
              default = "";
            };
          };
        });
        default = [];
      };

    config = mkIf cfg.enable {
      modules.editors.neovim.languageSupport = defaultSources;
      home.file =
        builtins.listToAttrs (builtins.map mkLspServer servers)
        // {
          ".config/astronvim/lua/user/lsp/servers.lua".text = ''
            return {
              ${formattedLspServerNames}
            }
          '';

          ".config/astronvim/lua/user/plugins/null-ls.lua".text = ''
            return {
              "jose-elias-alvarez/null-ls.nvim",
              opts = function(_, config)
                local null_ls = require("null-ls")
                config.sources = {
                  ${null-ls-settings}
                }
                return config
              end
            }
          '';
        };
    };
  }
