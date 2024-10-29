{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.browsers.floorp;
in
with lib;
{
  options.adace.desktop.browsers.floorp = {
    enable = mkEnableOption "Floorp";
    isDefaultBrowser = mkEnableOption "Set Floorp as default browser";
  };
  config = mkIf cfg.enable {
    home.file.".config/tridactyl/tridactylrc".source = ./tridactylrc;

    xdg.mimeApps.defaultApplications = mkIf cfg.isDefaultBrowser {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "floorp.desktop";
      "x-scheme-handler/https" = "floorp.desktop";
      "x-scheme-handler/about" = "floorp.desktop";
      "x-scheme-handler/unknown" = "floorp.desktop";
    };
    home.sessionVariables.BROWSER = mkIf cfg.isDefaultBrowser "floorp";

    programs.firefox = {
      enable = true;
      package = pkgs.floorp.override {
        nativeMessagingHosts = [ pkgs.tridactyl-native ];
        cfg = {
          browser.pipewireSupport = true;
        };
      };

      profiles.default = {
        extensions =
          with pkgs.nur.repos.rycee.firefox-addons;
          [
            ublock-origin
            tridactyl
            nighttab
            tree-style-tab
            darkreader
            return-youtube-dislikes
          ]
          ++ (with pkgs.nur.repos.bandithedoge.firefoxAddons; [ material-icons-for-github ]);
        bookmarks = [
          {
            name = "Bookmarked sites";
            toolbar = true;
            bookmarks = [
              {
                name = "Wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Portal:Current_events";
              }
              {
                name = "YouTube";
                keyword = "YouTube";
                url = "https://youtube.com/feed/subscriptions";
              }
              {
                name = "Amazon";
                keyword = "Amazon";
                url = "https://amazon.com";
              }
              {
                name = "Ebay";
                keyword = "Ebay";
                url = "https://ebay.com";
              }
              {
                name = "Gmail";
                keyword = "Gmail";
                url = "https://mail.google.com/mail/ca/u/0/#inbox";
              }
              {
                name = "GitHub";
                keyword = "GitHub";
                url = "https://github.com";
              }
              {
                name = "Hacker News";
                keyword = "Hacker News";
                url = "https://news.ycombinator.com";
              }
              {
                name = "Lobsters";
                keyword = "Lobsters";
                url = "https://lobste.rs";
              }
              {
                name = "Perplexity";
                keyword = "Perplexity";
                url = "https://beta.perplexity.ai";
              }
              {
                name = "Phind";
                keyword = "Phind";
                url = "https://phind.com";
              }
              {
                name = "NixOS";
                keyword = "NixOS";
                url = "https://search.nixos.org";
              }
              {
                name = "Notion";
                keyword = "Notion";
                url = "https://notion.so";
              }
            ];
          }
        ];

        settings = {
          "general.smoothScroll" = true;
          "extensions.pocket.enabled" = false;
          "browser.search.suggest.enabled" = true;
          "browser.fullscreen.autohide" = false;
          "browser.toolbars.bookmarks.visibility" = "always";
          "browser.startup.page" = 3;
          "browser.sessionstore.warnOnQuit" = true;
          "media.autoplay.default" = 2;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Floorp-specific settings
          "floorp.browser.tabs.verticaltab.enabled" = true;
          "floorp.browser.tabs.verticaltab" = true;
          "floorp.browser.tabs.verticaltab.width" = 208;
          "floorp.browser.user.interface" = 1;
          "floorp.tabsleep.enabled" = true;
          "floorp.verticaltab.hover.enabled" = true;
          "floorp.verticaltab.show.newtab.button" = true;
        };
      };
    };
  };
}
