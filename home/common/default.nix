{
  inputs,
  username,
  ...
}: {
  programs.home-manager.enable = true;
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
  };
}
