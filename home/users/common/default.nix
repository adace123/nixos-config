{
  inputs,
  username,
  lib,
  ...
}:
with lib; {
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
    sessionVariables = {
      TERMINAL = mkDefault "wezterm";
      BROWSER = mkDefault "firefox";
      EDITOR = mkDefault "nvim";
    };
  };
}
