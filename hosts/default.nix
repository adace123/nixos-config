{
  nixpkgs,
  inputs,
  outputs,
  system ? "x86_64-linux",
  ...
}: let
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules/nixos
    ./common
  ];

  overlays = [
    inputs.nuenv.overlays.nuenv
    inputs.nur.overlay
    outputs.overlays.default
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
        ./common/home-manager.nix
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
  # iso = mkSystem "iso";
  # vm = mkSystem "vm";
}
