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
          ./${host}
          {
            networking.hostName = host;
          }
          inputs.home-manager.nixosModules.home-manager
          {
            imports = [./common/home-manager.nix];
            home-manager.extraSpecialArgs = {inherit host;};
          }
        ]
        ++ sharedModules;
      specialArgs = {inherit inputs system;};
    };
in {
  coruscant = mkSystem "coruscant";
}
