{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.browsers.firefox;
in
  with lib; {
    options.modules.desktop.browsers.firefox.enable = mkEnableOption "Firefox browser";
    config = mkIf cfg.enable {
      home.sessionVariables.BROWSER = "firefox";

      # home.file.".mozilla/firefox/default/chrome".source = "${inputs.amadeus-dotfiles-hyprland}/dots/firefox/chrome";
      home.file.".mozille/firefox/default/night-tab".source = "${inputs.amadeus-dotfiles-hyprland}/dots/firefox/night-tab";
      home.file.".mozille/firefox/default/treestyletab".source = "${inputs.amadeus-dotfiles-hyprland}/dots/firefox/treestyletab";
      home.file.".config/tridactyl/tridactylrc".source = ./tridactyl/tridactylrc;
      home.file.".config/tridactyl/themes/catppuccin.css".source = ./tridactyl/themes/catppuccin.css;

      programs.firefox = {
        enable = true;
        package =
          (
            if config.modules.desktop.hyprland.enable
            then pkgs.firefox-wayland
            else pkgs.firefox
          )
          .override {
            cfg = {
              enableTridactylNative = true;
              browser.pipewireSupport = true;
            };
          };

        profiles.default = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons;
            [
              ublock-origin
              tridactyl
              nighttab
              tree-style-tab
              darkreader
              bypass-paywalls-clean
              return-youtube-dislikes
              pkgs.firefox-theme-catppuccin-mocha
            ]
            ++ (with pkgs.nur.repos.bandithedoge.firefoxAddons; [
              material-icons-for-github
            ]);

          bookmarks = [
            {
              name = "Bookmarked sites";
              toolbar = true;
              bookmarks = [
                {
                  name = "Wikipedia";
                  tags = ["wiki"];
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
          };
        };
      };
    };
  }
