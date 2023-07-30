{
  config,
  lib,
  ...
}: let
  cfg = config.modules.browsers.qutebrowser;
in
  with lib; {
    options.modules.browsers.qutebrowser.enable = mkEnableOption "qutebrowser";
    config = mkIf cfg.enable {
      programs.qutebrowser = {
        enable = true;
        settings = {
          tabs.show = "never";
          tabs.mode_on_change = "passthrough";
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
          arxiv = "https://arxiv.org/search/?query=%s&searchtype=all&source=header";
          ebay = "https://www.ebay.com/sch/items/?_nkw={}";
          gh = "https://github.com/search?utf8=/%E2%9C%93&q={}&type=";
          gh-nix = "https://github.com/search?q=%s+language:Nix&type=code";
          lbb = "http://libgen.is/search.php?req=%s&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def";
          nix = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
          nw = "https://nixos.wiki/index.php?search={}&go=Go";
          p = "https://perplexity.ai/search/?q=%s";
          ph = "https://phind.com/search?q=%s";
          w = "https://en.wikipedia.org/?search={}";
        };
      };
    };
  }
