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
in {
  coruscant = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [./coruscant] ++ sharedModules;
    specialArgs = {inherit inputs;};
  };
}
