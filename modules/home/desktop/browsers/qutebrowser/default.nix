{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.browsers.qutebrowser;
in
  with lib; {
    options.modules.desktop.browsers.qutebrowser = {
      enable = mkEnableOption "qutebrowser";
      isDefaultBrowser = mkEnableOption "set qutebrowser as default";
    };
    config = mkIf cfg.enable {
      home.packages = [pkgs.python311Packages.adblock];
      xdg.mimeApps.defaultApplications = mkIf cfg.isDefaultBrowser {
        "text/html" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
        "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
      };
      home.sessionVariables.BROWSER = mkIf cfg.isDefaultBrowser "qutebrowser";
      xdg.configFile."qutebrowser/greasemonkey/youtube-sponsorblock.js".source =
        pkgs.fetchurl
        {
          name = "qute-youtube-adblock.js";
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_adblock.js";
          sha256 = "sha256-EuGTJ9Am5C6g3MeTsjBQqyNFBiGAIWh+f6cUtEHu3iI=";
        };

      home.file.".config/qutebrowser/catppuccin" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "qutebrowser";
          rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
          sha256 = "sha256-lp7HWYuD4aUyX1nRipldEojZVIvQmsxjYATdyHWph0g=";
        };
      };

      programs.qutebrowser = {
        enable = true;
        extraConfig = ''
          import catppuccin
          catppuccin.setup(c, "mocha", False)
        '';
        keyBindings = {
          normal = {
            ",a" = "cmd-set-text -s :open -t amazon";
            ",e" = "cmd-set-text -s :open -t ebay";
            ",g" = "cmd-set-text -s :open -t github";
            ",n" = "cmd-set-text -s :open -t nixpkgs";
            ",N" = "cmd-set-text -s :open -t nix-code";
            ",y" = "cmd-set-text -s :open -t youtube";
            ",p" = "cmd-set-text -s :open -t perplexity";
            ",w" = "cmd-set-text -s :open -t wikipedia";
            ",x" = "cmd-set-text -s :open -t arxiv";
            "tt" = "config-cycle tabs.show always never";
            "gu" = "hint inputs --first;; cmd-later 3 fake-key <Shift-Home>;; cmd-later 3 fake-key <Delete>";
            "<Alt-d>" = "config-cycle colors.webpage.darkmode.enabled";
            "<Ctrl-Shift-i>" = "devtools";
            "<Ctrl-p>" = "print";
          };
          insert = {
            "<Ctrl-b>" = "fake-key <Left>";
            "<Ctrl-f>" = "fake-key <Right>";
            "<Ctrl-Shift-b>" = "fake-key <Ctrl-Left>";
            "<Ctrl-Shift-f>" = "fake-key <Ctrl-Right>";
            "<Ctrl-d>" = "fake-key <Delete>";
            "<Ctrl-k>" = "fake-key <Shift-End> ;; fake-key <Delete>";
            "<Ctrl-e>" = "fake-key <End>";
            "<Ctrl-a>" = "fake-key <Home>";
            "<Ctrl-w>" = "fake-key <Ctrl-Backspace>";
            "<Ctrl-u>" = "fake-key <Shift-Home>;; cmd-later 3 fake-key <Delete>";
          };
        };
        settings = {
          url.start_pages = "https://google.com";
          url.default_page = "https://google.com";
          downloads.location.directory = "~/Downloads";
          confirm_quit = ["multiple-tabs" "downloads"];
          auto_save.session = true;
          qt.highdpi = true;
          colors.webpage.darkmode.enabled = true;
          qt.args = [
            "enable-accelerated-video-decode"
            "enable-gpu-rasterization"
            "ignore-gpu-blocklist"
            "use-egl=desktop"
            "enable-native-gpu-memory-buffers"
          ];
          content = {
            autoplay = false;
            blocking = {
              enabled = true;
              method = "both";
              adblock.lists = [
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_11_Mobile/filter.txt"
                "https://easylist.to/easylist/easylist.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_3_Spyware/filter.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_17_TrackParam/filter.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt"
                "https://easylist.to/easylist/easyprivacy.txt"
                "https://curben.gitlab.io/malware-filter/urlhaus-filter.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_14_Annoyances/filter.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_4_Social/filter.txt"
                "https://secure.fanboy.co.nz/fanboy-antifacebook.txt"
                "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
                "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
                "https://easylist.to/easylist/fanboy-social.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
                "https://someonewhocares.org/hosts/hosts"
                "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&mimetype=plaintext"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_16_French/filter.txt"
                "https://easylist-downloads.adblockplus.org/easylistitaly.txt"
                "https://easylist-downloads.adblockplus.org/advblock.txt"
                "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
                "https://raw.githubusercontent.com/gioxx/xfiles/master/filtri.txt"
                "https://secure.fanboy.co.nz/enhancedstats.txt"
                "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt"
              ];

              hosts.lists = [
                "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt"
                "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
              ];
            };
          };
          tabs = {
            background = true;
            position = "left";
            width = "15%";
          };
          fonts = {
            default_family = "JetBrainsMono Nerd Font";
            default_size = "16pt";
          };
          zoom.default = 125;
          editor.command = ["kitty" "-e" "${pkgs.neovim}/bin/nvim" "{file}"];
        };

        aliases = {
          ff = "spawn firefox {url}";
          q = "quit";
          wq = "quit --save";
          yt = "open https://youtube.com/feed/subscriptions";
          pw = "open https://1ft.io/proxy?q={url}";
          gpw = "open https://www.google.com/search?q=cache:{url}";
        };

        searchEngines = {
          DEFAULT = "https://google.com/search?hl=en&q={}";
          amazon = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords={}";
          arxiv = "https://arxiv.org/search/?query={}&searchtype=all&source=header";
          ebay = "https://www.ebay.com/sch/items/?_nkw={}";
          github = "https://github.com/search?q={}";
          github-nix = "https://github.com/search?q={}+language:Nix&type=code";
          nix-code = "https://github.com/search?q={}+language:Nix&type=code";
          nixpkgs = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
          perplexity = "https://perplexity.ai/search/?q={}";
          wikipedia = "https://en.wikipedia.org/?search={}";
          youtube = "https://youtube.com/results?q={}";
        };

        quickmarks = {
          amazon = "https://amazon.com";
          ebay = "https://ebay.com";
          github = "https://github.com";
          gmail = "https://mail.google.com/mail/u/0/#inbox";
          google = "https://google.com";
          hackernews = "https://news.ycombinator.com";
          lobsters = "https://lobste.rs";
          reddit = "https://reddit.com";
          notion = "https://notion.so";
          nixpkgs = "https://search.nixos.org";
          protonmail = "https://mail.proton.me/u/0/inbox";
          youtube = "https://www.youtube.com/feed/subscriptions";
          wikipedia = "https://en.wikipedia.org/wiki/Portal:Current_events";
        };
      };
    };
  }
