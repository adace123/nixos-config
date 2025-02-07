{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    devenv
    mkcert
    hurl
    # snowflake-cli
    tailscale
  ];
  home.stateVersion = "23.11";
  snowfallorg.user = {
    enable = true;
    name = "aaron";
  };
  adace = {
    security.sops.enable = true;
    suites = {
      development.enable = true;
      terminal.enable = true;
    };
    terminal.tools.zellij.defaultLayout = "work";
  };
  programs.kitty.settings.startup_session = "~/.config/kitty/work.conf";
}
