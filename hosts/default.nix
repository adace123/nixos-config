{
  nixpkgs,
  inputs,
  system ? "x86_64-linux",
  ...
}: let
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules/nixos
    ./common
  ];

  overlays = [inputs.nuenv.overlays.nuenv];

  pkgs = import nixpkgs {inherit overlays system;};

  mkSystem = host:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ./common/home-manager.nix
          ./${host}
          ../installer/script.nix
          {
            networking.hostName = host;
            home-manager.extraSpecialArgs = {inherit host inputs;};
          }
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ sharedModules;
      specialArgs = {inherit inputs system pkgs;};
    };
in {
  coruscant = mkSystem "coruscant";
}
