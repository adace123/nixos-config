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

  mkSystem = host:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ./common/home-manager.nix
          ./${host}
          {
            networking.hostName = host;
            home-manager.extraSpecialArgs = {inherit host inputs;};
          }
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ sharedModules;
      specialArgs = {inherit inputs system;};
    };
in {
  coruscant = mkSystem "coruscant";
}
