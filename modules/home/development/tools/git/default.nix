{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.development.tools.git;
in
with lib;
{
  options.adace.development.tools.git = {
    enable = mkEnableOption "git user config";
    signingKey = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable {
    sops.secrets.github-private-key = { };
    home.packages = with pkgs; [
      pre-commit
      delta
    ];
    programs = {
      git = {
        enable = true;
        delta.enable = true;
        # userName = "adace123";
        # userEmail = "18275490+adace123@users.noreply.github.com";

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
          identityFile = config.sops.secrets.github-private-key.path;
        };
      };
    };
  };
}
