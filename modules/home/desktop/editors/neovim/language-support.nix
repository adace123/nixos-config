# TODO: This will need to be refactored once null-ls is deprecated
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.neovim;
  mkLspServer = server: {
    name = ".config/astronvim/lua/user/lsp/config/${server.name}.lua";
    value = {
      text = ''
        return {
          cmd = { "${lib.getExe server.package}" },
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
    null_ls.builtins.${x.type}.${x.name}.with({ prefer_local = "${lib.getExe x.package}" })
  '');
  null-ls-settings = builtins.concatStringsSep ", " (
    (null-ls-builder formatters)
    ++ (null-ls-builder diagnostics)
  );

  defaultLsps = [
    {
      name = "nixd";
      package = pkgs.nixd;
      type = "lsp";
    }
    {
      name = "lua_ls";
      package = pkgs.lua-language-server;
      type = "lsp";
    }
    {
      name = "yamlls";
      package = pkgs.yaml-language-server;
      type = "lsp";
    }
    {
      name = "taplo";
      package = pkgs.taplo-lsp;
      type = "lsp";
    }
  ];

  defaultFormatters = [
    {
      name = "alejandra";
      package = pkgs.alejandra;
      type = "formatting";
    }
    {
      name = "stylua";
      package = pkgs.stylua;
      type = "formatting";
    }
    {
      name = "yamlfmt";
      package = pkgs.yamlfmt;
      type = "formatting";
    }
  ];

  defaultDiagnostics = [
    {
      name = "selene";
      package = pkgs.selene;
      type = "diagnostics";
    }
    {
      name = "yamllint";
      package = pkgs.yamllint;
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
            package = mkOption {type = package;};
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

      programs.neovim.extraPackages = builtins.map (l: l.package) cfg.languageSupport;

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
