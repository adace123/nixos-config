{
  nixpkgs,
  inputs,
  ...
}: let
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules
    ./common
  ];

  desktopModules = with inputs; [
    hyprland.nixosModules.default
  ];
in {
  coruscant = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with inputs;
      [
        ./coruscant
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = {
              inherit inputs;
              username = "aaron";
            };
            users.aaron.imports = [
              ../home/users/aaron
            ];
          };
        }
      ]
      ++ sharedModules
      ++ desktopModules;
    specialArgs = {inherit inputs;};
  };
}
