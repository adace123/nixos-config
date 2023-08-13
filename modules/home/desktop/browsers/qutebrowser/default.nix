{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.browsers.qutebrowser;
in
  with lib; {
    options.modules.desktop.browsers.qutebrowser.enable = mkEnableOption "qutebrowser";
    config = mkIf cfg.enable {
      home.packages = [pkgs.python311Packages.adblock];
      xdg.configFile."qutebrowser/greasemonkey/youtube-sponsorblock.js".source =
        pkgs.fetchurl
        {
          name = "qute-youtube-adblock.js";
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_adblock.js";
          sha256 = "sha256-EuGTJ9Am5C6g3MeTsjBQqyNFBiGAIWh+f6cUtEHu3iI=";
        };
      programs.qutebrowser = {
        enable = true;
        keyBindings = {
          normal = {
            ",a" = "set-cmd-text -s :open -t amazon";
            ",e" = "set-cmd-text -s :open -t ebay";
            ",g" = "set-cmd-text -s :open -t github";
            ",n" = "set-cmd-text -s :open -t nixpkgs";
            ",N" = "set-cmd-text -s :open -t nix-code";
            ",y" = "set-cmd-text -s :open -t youtube";
            ",p" = "set-cmd-text -s :open -t perplexity";
            ",w" = "set-cmd-text -s :open -t wikipedia";
            "tt" = "set tabs.show never";
            "tT" = "set tabs.show always";
            "gu" = "hint inputs --first;; fake-key <Shift-Home>;; fake-key <Delete>";
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
            "<Ctrl-u>" = "fake-key <Shift-Home>;; later 3 fake-key <Delete>";
          };
        };
        settings = {
          url.start_pages = "https://google.com";
          url.default_page = "https://google.com";
          downloads.location.directory = "~/Downloads";
          confirm_quit = ["multiple-tabs"];
          auto_save.session = true;
          content = {
            autoplay = false;
            blocking = {
              adblock.lists = [
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
                "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_English/filter.txt"
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

              method = "both";
            };
          };
          tabs = {
            show = "never";
            background = true;
            position = "left";
            width = "10%";
          };
          colors = import ./theme.nix {inherit config;};
          fonts = {
            default_size = "18px";
            default_family = "JetBrainsMono Nerd Font";
          };
          zoom.default = "140%";
          editor.command = ["${pkgs.alacritty}/bin/alacritty" "-e" "${pkgs.neovim}/bin/nvim" "{file}"];
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
          nixpkgs = "https://github.com/NixOS/nixpkgs";
          protonmail = "https://mail.proton.me/u/0/inbox";
          youtube = "https://youtube.com";
          wikipedia = "https://en.wikipedia.org/wiki/Portal:Current_events";
        };
      };
    };
  }
