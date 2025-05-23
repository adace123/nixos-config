{
  config,
  lib,

  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.browsers.qutebrowser;
in
with lib;
{
  options.adace.desktop.browsers.qutebrowser = {
    enable = mkEnableOption "qutebrowser";
    isDefaultBrowser = mkEnableOption "set qutebrowser as default";
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.python311Packages.adblock ];
    xdg.mimeApps.defaultApplications = mkIf cfg.isDefaultBrowser {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
    home.sessionVariables.BROWSER = mkIf cfg.isDefaultBrowser "qutebrowser";
    xdg.configFile."qutebrowser/greasemonkey/youtube-adblock.js".source = pkgs.fetchurl {
      name = "qute-youtube-adblock.js";
      url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_adblock.js";
      sha256 = "sha256-EuGTJ9Am5C6g3MeTsjBQqyNFBiGAIWh+f6cUtEHu3iI=";
    };
    xdg.configFile."qutebrowser/greasemonkey/youtube-sponsorblock.js".source = pkgs.fetchurl {
      name = "qute-youtube-sponsorblock.js";
      url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_sponsorblock.js";
      sha256 = "sha256-e3QgDPa3AOpPyzwvVjPQyEsSUC9goisjBUDMxLwg8ZE=";
    };

    programs.qutebrowser = {
      enable = true;
      extraConfig = ''
        # Appearance
        c.statusbar.padding['bottom'] = 5
        c.statusbar.padding['left'] = 5
        c.statusbar.padding['right'] = 5
        c.statusbar.padding['top'] = 5
        c.tabs.padding['bottom'] = 5
        c.tabs.padding['left'] = 0
        c.tabs.padding['right'] = 5
        c.tabs.padding['top'] = 5
        c.tabs.title.format = "{current_title}"

        # Theme
        import catppuccin
        catppuccin.setup(c, "mocha", False)
      '';
      keyBindings = {
        normal = {
          "sa" = "cmd-set-text -s :open -t amazon";
          "se" = "cmd-set-text -s :open -t ebay";
          "sg" = "cmd-set-text -s :open -t github";
          "sm" = "cmd-set-text -s :open -t maps";
          "sN" = "cmd-set-text -s :open -t nixpkgs";
          "sn" = "cmd-set-text -s :open -t nix-code";
          "sy" = "cmd-set-text -s :open -t youtube";
          "sp" = "cmd-set-text -s :open -t perplexity";
          "sw" = "cmd-set-text -s :open -t wikipedia";
          "sx" = "cmd-set-text -s :open -t arxiv";
          ";m" = "hint links spawn --detach mpv {hint-url}";
          "tt" = "config-cycle tabs.show always never";
          "gu" = "hint inputs --first;; cmd-later 3 fake-key <Shift-Home>;; cmd-later 3 fake-key <Delete>";
          "<Alt-d>" = "config-cycle colors.webpage.darkmode.enabled";
          "<Ctrl-Shift-i>" = "devtools";
          "<Ctrl-Shift-h>" = "history";
          "<Ctrl-p>" = "print";
          "<Ctrl-Shift-o>" = "cmd-set-text -s :open -p";
          "<" = "tab-move -";
          ">" = "tab-move +";
          ";M" = "hint links spawn --detach mpv --ytdl --no-video --force-window=immediate {hint-url}";
          ",dm" =
            ''hint links spawn --verbose yt-dlp -x {hint-url} --embed-thumbnail --embed-metadata --audio-format mp3 --audio-quality 0 -o "$HOME/music/%(artist)s/%(title)s.%(ext)s" '';
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
          "<Ctrl-Return>" = "mode-enter normal";
        };
        command = {
          "<Ctrl-j>" = "completion-item-focus next";
          "<Ctrl-k>" = "completion-item-focus prev";
        };
      };
      settings = {
        url.start_pages = "https://perplexity.ai";
        url.default_page = "https://perplexity.ai";
        downloads.location.directory = "~/Downloads";
        confirm_quit = [
          "multiple-tabs"
          "downloads"
        ];
        auto_save.session = true;
        qt.highdpi = true;
        colors.webpage.darkmode.enabled = true;

        input.insert_mode = {
          auto_enter = true;
          auto_leave = true;
          auto_load = true;
        };

        hints = {
          auto_follow = "unique-match";
          auto_follow_timeout = 700;
        };

        completion = {
          height = "30%";
          open_categories = [
            "quickmarks"
            "bookmarks"
            "history"
          ];
          scrollbar = {
            padding = 0;
            width = 0;
          };
          show = "always";
          shrink = true;
          timestamp_format = "";
        };

        qt.args = [
          "enable-accelerated-video-decode"
          "enable-gpu-rasterization"
          "ignore-gpu-blocklist"
          "use-egl=desktop"
          "enable-native-gpu-memory-buffers"
        ];

        content = {
          autoplay = false;
          cookies.accept = "no-3rdparty";
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
              "https://raw.githubusercontent.com/Ewpratten/youtube_ad_blocklist/master/blocklist.txt"
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
          title.format = "{audio}{private} {current_title}";
        };
        fonts = {
          default_family = "JetBrainsMono Nerd Font";
          default_size = "16pt";
        };
        zoom.default = 125;
        editor.command = [
          "kitty"
          "-e"
          "${pkgs.neovim}/bin/nvim"
          "{file}"
        ];
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
        maps = "https://maps.google.com/maps?q={}";
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
        nix-search = "https://search.nixos.org";
        nixpkgs = "https://github.com/NixOS/nixpkgs";
        perplexity = "https://perplexity.ai";
        protonmail = "https://mail.proton.me/u/0/inbox";
        youtube = "https://www.youtube.com/feed/subscriptions";
        wikipedia = "https://en.wikipedia.org/wiki/Portal:Current_events";
      };
    };
  };
}
