{
  inputs,
  overlays,
  ...
}:
with inputs; let
  pkgsForSystem = system:
    import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
in {
  mkNixosSystem = {
    system,
    host,
    fullBuild ? false,
  }: let
    pkgs = pkgsForSystem system;
    inherit (pkgs) lib;
  in
    pkgs.lib.nixosSystem {
      inherit system;
      modules = [
      ];
      specialArgs = {
        inherit host inputs system pkgs fullBuild;
        std = inputs.nix-std.lib;
      };
    };

  mkDarwinSystem = {
    system,
    host,
  }: let
    pkgs = pkgsForSystem system;
    inherit (pkgs) lib;
  in
    darwin.lib.darwinSystem {
      inherit system;
      modules = [
        home-manager.darwinModules.home-manager
        ../modules/nixos/core/nix.nix
        ../darwin/modules
        ../hosts/${host}/system.nix
        ../modules/home/home-manager.nix
        {
          # TODO: cleanup
          options.modules.user.name = lib.mkOption {
            type = lib.types.str;
            description = "Default user name";
          };
        }
        # nixvim.nixDarwinModules.nixvim
        {
          home-manager.extraSpecialArgs = {inherit inputs pkgs host;};
        }
      ];
      specialArgs = {
        inherit inputs pkgs host;
      };
    };
}
