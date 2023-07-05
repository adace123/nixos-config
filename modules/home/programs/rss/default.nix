{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.feeds;
in
  with lib; {
    options.modules.feeds = {
      enable = mkEnableOption "Newsboat";
      auto-refresh = mkEnableOption "Auto-refresh feeds";
    };
    config = mkIf cfg.enable {
      systemd.user = mkIf cfg.auto-refresh {
        services.newsboat-refresh = {
          Unit.Description = "Auto-refresh Newsboat feeds";
          Service = {
            ExecStart = "${pkgs.newsboat}/bin/newsboat -x reload";
            ExecStartPost = "${pkgs.newsboat}/bin/newsboat --cleanup";
          };
        };
        timers.newsboat-refresh = {
          Unit.Description = "Auto-refresh Newsboat feeds";
          Timer = {
            OnCalendar = "hourly";
            Unit = "newsboat-refresh.service";
          };
          Install.WantedBy = ["timers.target"];
        };
      };

      programs.newsboat = {
        enable = true;
        extraConfig = ''
          include ${pkgs.newsboat}/share/doc/newsboat/contrib/colorschemes/nord

          reload-threads 6
          max-items 500
          download-retries 3
          browser "firefox --new-tab %u"


          unbind-key j
          unbind-key k
          unbind-key J
          unbind-key K
          unbind-key g
          unbind-key G

          bind-key j down
          bind-key k up
          bind-key h quit
          bind-key l open
          bind-key H prev-feed
          bind-key L next-feed
          bind-key g home
          bind-key G end
          bind-key u pageup
          bind-key d pagedown
          bind-key s sort
          bind-key S rev-sort
          bind-key SPACE	toggle-article-read

          feed-sort-order lastupdated

          macro y set browser "echo -n %u | wl-copy"; open-in-browser; set browser "firefox --new-tab %u"

          html-renderer "${pkgs.w3m}/bin/w3m -dump -T text/html"
        '';
        urls =
          [
            {
              title = "Unread";
              url = ''"query:Unread Articles:unread = \"yes\""'';
              tags = ["meta"];
            }
            {
              title = "GitHub";
              url = "https://github.blog/category/engineering/feed";
              tags = ["ai" "git" "misc"];
            }
            {
              title = "xkcd";
              url = "https://xkcd.com/rss.xml";
              tags = ["misc"];
            }
          ]
          ++ (import ./feeds/hardware.nix)
          ++ (import ./feeds/programming.nix)
          ++ (import ./feeds/devops.nix)
          ++ (import ./feeds/linux.nix)
          ++ (import ./feeds/github.nix {}).formatted-releases;
      };
    };
  }
