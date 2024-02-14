{
  nixpkgs,
  inputs,
  overlays,
  ...
}: let
  pkgs = import nixpkgs {
    inherit overlays system;
    config.allowUnfree = true;
  };
  # TODO: update to aarch64-darwin
  system = "x86_64-darwin";
in
  with inputs; {
    endor = darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit inputs pkgs;
        user = "aaronfeigenbaum";
      };
      modules = [
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        inputs.nixvim.nixDarwinModules.nixvim
        ../modules/home/desktop/editors/neovim
        ./modules
      ];
    };
  }
