{
  lib,
  user,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ../../modules/nixos/core/nix.nix
  ];
  services.nix-daemon.enable = true;

  system.stateVersion = 4;

  users.users.${user} = {
    home = "/Users/${user}";
  };

  home-manager = {
    users.${user} = {
      home.stateVersion = "22.05";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  modules = {
    editors.neovim.enable = true;
  };
  # TODO: reenable on new laptop
  # homebrew = {
  #   enable = true;
  #   onActivation = {
  #     autoUpdate = false;
  #     upgrade = false;
  #     cleanup = "zap";
  #   };
  # };
}
