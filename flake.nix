{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
    mkHome = user: {
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit defaultSystem;};
        modules = [
          ./home/users/${user}
        ];
        extraSpecialArgs = {inherit inputs;};
      };
    };
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
        packages.infra = import ./infra {inherit pkgs;};
      };

      flake = {
        nixosConfigurations = import ./hosts {inherit inputs nixpkgs;};
        homeConfigurations = {
          aaron = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {system = defaultSystem;};
            modules = [
              ./home/users/aaron
            ];
            extraSpecialArgs = {
              inherit inputs;
              username = "aaron";
            };
          };
        };
        # nixosConfigurations = {
        # coruscant = nixpkgs.lib.nixosSystem {
        #   system = defaultSystem;
        #   modules = [
        #     ./hosts/coruscant
        #     ./modules/nixos
        #     sops-nix.nixosModules.sops
        #     hyprland.nixosModules.default
        #     inputs.home-manager.nixosModules.home-manager
        #   ];
        #   specialArgs = {inherit inputs;};
        # };
        # };

        # homeConfigurations = {
        #   aaron =
        #     home-manager.lib.homeManagerConfiguration {
        #       pkgs = import nixpkgs {system = defaultSystem;};
        #       modules = [
        #         ./home/users/aaron
        #       ];
        #       extraSpecialArgs = {
        #         inherit inputs;
        #       };
        #     };
        # };
      };
    });
}
