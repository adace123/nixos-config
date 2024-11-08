_: {
  home.stateVersion = "23.11";
  snowfallorg.user = {
    enable = true;
    name = "aaron";
  };
  adace.suites = {
    desktop.enable = true;
    development.enable = true;
    terminal.enable = true;
  };
  adace.home.desktop.monitor = {
    output = "DP-2";
    resolution = "2560x1440";
  };
  adace.services = {
    security.sops.enable = true;
    ai = {
      ollama = {
        enable = false;
        acceleration = "cuda";
      };
    };
  };
}
