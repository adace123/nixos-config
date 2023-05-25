{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nuenv.url = "github:DeterminateSystems/nuenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nuenv,
    sops-nix,
    flake-parts,
    hyprland,
    home-manager,
    ...
  } @ inputs: let
    defaultSystem = "x86_64-linux";
    overlays = [nuenv.overlays.nuenv];
  in
    flake-parts.lib.mkFlake {inherit inputs;} (_: {
      systems = ["x86_64-linux" "x86_64-darwin"];
      perSystem = {
        pkgs,
        lib,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [just statix alejandra sops ssh-to-age pulumi];
        };
        # packages.infra = import ./infra {inherit pkgs;};
      };

      flake = {
        nixosConfigurations = import ./hosts {inherit inputs nixpkgs;};
      };
    });
}
