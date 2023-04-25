{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuenv.url = "github:DeterminateSystems/nuenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nuenv,
    sops-nix,
    flake-parts,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays = [nuenv.overlays.nuenv];
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "x86_64-darwin"];
      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [just statix alejandra sops];
        };
      };

      flake = {
        nixosConfigurations = {
          coruscant = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/coruscant
              ./modules/nixos
              sops-nix.nixosModules.sops
            ];
            specialArgs = {inherit inputs;};
          };
        };
      };
    });
}
