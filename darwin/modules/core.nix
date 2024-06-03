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
      ../../modules/nixos/core/packages.nix
      ./system.nix
      ./yabai.nix
      ./homebrew.nix
    ];
    services.nix-daemon.enable = true;

    nix = {
      extraOptions = ''
        extra-platforms = aarch64-darwin
      '';
      gc = {
        interval = {
          Hour = 12;
          Minute = 0;
          Day = 0;
        };
        user = "root";
      };
      linux-builder.enable = true;
    };

    users.users.${user} = {
      home = "/Users/${user}";
      shell = pkgs.nushellFull;
    };
  }
