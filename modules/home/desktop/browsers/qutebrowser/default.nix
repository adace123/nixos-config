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
      programs.qutebrowser = {
        enable = true;
        keyBindings = {
          normal = {
            ",a" = "set-cmd-text :open -T amazon ";
            "tt" = "set tabs.show never";
            "tT" = "set tabs.show always";
            "gu" = "hint inputs --first;; fake-key <Ctrl-u>";
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
        };

        aliases = {
          ff = "spawn firefox {url}";
          q = "quit";
          wq = "quit --save";
          yt = "open https://youtube.com/feed/subscriptions";
        };

        searchEngines = {
          DEFAULT = "https://google.com/search?hl=en&q={}";
          amazon = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords={}";
          arxiv = "https://arxiv.org/search/?query={}&searchtype=all&source=header";
          ebay = "https://www.ebay.com/sch/items/?_nkw={}";
          gh = "https://github.com/search?utf8=/%E2%9C%93&q={}&type=";
          gh-nix = "https://github.com/search?q={}+language:Nix&type=code";
          lbb = "http://libgen.is/search.php?req={}&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def";
          nix = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
          nw = "https://nixos.wiki/index.php?search={}&go=Go";
          p = "https://perplexity.ai/search/?q={}";
          ph = "https://phind.com/search?q={}";
          w = "https://en.wikipedia.org/?search={}";
        };
      };
    };
  }
