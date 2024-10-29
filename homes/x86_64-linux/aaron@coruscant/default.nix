_: {
  home.stateVersion = "23.11";
  adace.suites = {
    desktop.enable = true;
    development.enable = true;
    terminal.enable = true;
  };
  adace.home.desktop.monitor = {
    output = "DP-2";
    resolution = "2560x1440";
  };
  adace.services.sops.enable = true;
}
