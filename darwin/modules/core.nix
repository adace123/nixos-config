{
  lib,
  config,
  ...
}: let
  user = config.modules.user.name;
in
  with lib; {
    imports = [
      ../../modules/nixos/core/nix.nix
      ./system.nix
      ./yabai.nix
      ./homebrew.nix
    ];
    services.nix-daemon.enable = true;

    nix.gc.interval = {
      Hour = 12;
      Minute = 0;
      Day = 0;
    };
    nix.gc.user = "root";

    users.users.${user} = {
      home = "/Users/${user}";
      shell = pkgs.nushell;
    };
  }
