{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.git;
in
  with lib; {
    options.modules.dev.git = {
      enable = mkEnableOption "git user config";
      signingKey = mkOption {type = types.str;};
    };

    config = mkIf cfg.enable {
      sops.secrets.github-private-key = {
        path = "/home/${config.home.username}/.ssh/github-private-key";
        mode = "0600";
      };
      programs = {
        git = {
          enable = true;
          difftastic.enable = true;
          userName = "adace123";
          userEmail = "18275490+adace123@users.noreply.github.com";

          ignores = [
            "*.log"
            "*.swp"
          ];

          aliases = {
            b = "branch --color -v";
            co = "checkout";
            lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
            dc = "diff --cached";
          };

          extraConfig = {
            init.defaultBranch = "main";
            core.editor = "nvim";
            push.autoSetupRemote = true;
            user.signingkey = config.sops.secrets.github-private-key.path;
            gpg.format = "ssh";
            commit.gpgsign = true;
          };
        };

        gh = {
          enable = true;
          settings.git_protocol = "ssh";
          extensions = with pkgs; [
            gh-dash
            gh-eco
          ];
        };
        ssh = {
          matchBlocks."github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = [config.sops.secrets.github-private-key.path];
          };
        };
      };
    };
  }
