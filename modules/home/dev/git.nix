{
  config,
  lib,
  pkgs,
  host,
  inputs,
  ...
}: let
  cfg = config.modules.dev.git;
in
  with lib; {
    options.modules.dev.git.enable = mkEnableOption "git user config";
    config = mkIf cfg.enable {
      programs.lazygit.enable = true;
      programs.git = {
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
          core.editor =
            if config.modules.editors.neovim.enable
            then "nvim"
            else "vim";
          url = {
            "https://github.com/".insteadOf = "gh:";
            "ssh://git@github.com".pushInsteadOf = "gh:";
          };
          push.autoSetupRemote = true;
        };
      };

      programs.gh = {
        enable = true;
        settings.git_protocol = "ssh";
        extensions = with pkgs; [
          gh-dash
          gh-eco
        ];
      };

      sops.secrets.github-private-key = {
        path = "${config.xdg.configHome}/git/credentials/github";
      };

      programs.ssh.matchBlocks."github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = ["${config.sops.secrets.github-private-key.path}"];
      };
    };
  }
