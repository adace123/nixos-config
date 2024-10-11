{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    mkcert
    devenv
  ];
  home.stateVersion = "23.11";
  snowfallorg.user = {
    enable = true;
    name = "aaron";
  };
  adace = {
    services = {
      sops.enable = true;
    };
    suites.development.enable = true;
  };
  programs.kitty.settings.startup_session = "~/.config/kitty/work.conf";
}
