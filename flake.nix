{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    darwinPkgs = import nixpkgs {system = "x86_64-darwin";};
  in {
    devShells = {
      ${system}.default = pkgs.mkShell {
        packages = with pkgs; [just statix alejandra];
      };
      "x86_64-darwin".default = darwinPkgs.mkShell {
        packages = with darwinPkgs; [just statix alejandra];
      };
    };

    nixosConfigurations = {
      hp-pavilion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/hp-pavilion
          ./modules/nixos
        ];
        specialArgs = {inherit inputs;};
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/vm
          ./modules/nixos
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
