{
  nixpkgs,
  inputs,
  overlays,
  system ? "x86_64-linux",
  ...
}: let
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules/nixos
  ];

  pkgs = import nixpkgs {
    inherit overlays system;
    config.allowUnfree = true;
  };

  mkSystem = {
    host,
    fullBuild ? true,
  }: let
    homeModules =
      if (builtins.pathExists ./${host}/home.nix && fullBuild)
      then [
        inputs.home-manager.nixosModules.home-manager
        ../modules/home/home-manager.nix
        {
          home-manager.extraSpecialArgs = {
            inherit host inputs pkgs;
            std = inputs.nix-std.lib;
          };
        }
      ]
      else [];
  in
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ./${host}
          {
            networking.hostName = host;
          }
        ]
        ++ homeModules
        ++ sharedModules;
      specialArgs = {
        inherit host inputs system pkgs fullBuild;
        std = inputs.nix-std.lib;
      };
    };
in {
  coruscant = mkSystem {host = "coruscant";};
  # The full system is too large to install via nixos-anywhere
  # Need to install a minimal version first
  coruscant-minimal = mkSystem {
    host = "coruscant";
    fullBuild = false;
  };
  iso = mkSystem {host = "iso";};
}
