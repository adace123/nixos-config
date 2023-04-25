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
    agenix.url = "github:ryantm/agenix";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nuenv,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays = [nuenv.overlays.nuenv];
    pkgs = import nixpkgs {inherit system overlays;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [just statix alejandra];
    };

    nixosConfigurations = {
      coruscant = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/coruscant
          ./modules/nixos
          sops-nix.nixosModules.sops
        ];
        specialArgs = {inherit inputs pkgs;};
      };

      # vm = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   modules = [
      #     ./hosts/vm
      #     ./modules/nixos
      #   ];
      #   specialArgs = {inherit inputs pkgs;};
      # };
    };
  };
}
