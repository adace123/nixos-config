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

  mkSystem = host: let
    homeModules =
      if builtins.pathExists ./${host}/home.nix
      then [
        inputs.home-manager.nixosModules.home-manager
        ./home-manager.nix
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
        inherit host inputs system pkgs;
        std = inputs.nix-std.lib;
      };
    };
in {
  coruscant = mkSystem "coruscant";
  iso = mkSystem "iso";
}
