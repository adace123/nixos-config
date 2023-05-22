{
  nixpkgs,
  inputs,
  system ? "x86_64-linux",
  ...
}: let
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules
    ./common
  ];

  mkSystem = host: username:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ./${host}
          {
            networking.hostName = host;
          }
        ]
        ++ sharedModules;
      specialArgs = {inherit inputs;};
    };
in {
  coruscant = mkSystem "coruscant" "aaron";
}
