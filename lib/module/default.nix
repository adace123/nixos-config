{
  inputs,
  ...
}:
{
  inherit (inputs.nix-std.lib.serde) toTOML;
  std = inputs.nix-std.lib;
  # toYAML =
  #   config:
  #   builtins.readFile (
  #     pkgs.runCommand "to-yaml" { } ''
  #       ${pkgs.yq}/bin/yq -y . ${pkgs.writeText "to-json" (builtins.toJSON config)}  > $out
  #     ''
  #   );
  # mkNixosSystem = {
  #   system ? "x86_64-linux",
  #   host,
  #   fullBuild ? true,
  # }: let
  #   pkgs = pkgsForSystem system;
  #   homeModules =
  #     if (builtins.pathExists ../hosts/${host}/home.nix && fullBuild)
  #     then [
  #       inputs.home-manager.nixosModules.home-manager
  #       ../modules/home/home-manager.nix
  #       {
  #         home-manager.extraSpecialArgs = {
  #           inherit host inputs pkgs;
  #           std = inputs.nix-std.lib;
  #         };
  #       }
  #     ]
  #     else [];
  #   modules =
  #     [
  #       ../hosts/${host}
  #       {
  #         networking.hostName = host;
  #         nix.gc.dates = "weekly"; # this option is only compatible with NixOS
  #       }
  #       catppuccin.nixosModules.catppuccin
  #       sops-nix.nixosModules.sops
  #       ../modules/nixos
  #     ]
  #     ++ homeModules;
  # in
  #   nixpkgs.lib.nixosSystem {
  #     inherit system modules;
  #     specialArgs = {
  #       inherit host inputs system pkgs fullBuild;
  #       std = inputs.nix-std.lib;
  #     };
  #   };
  #
  # mkDarwinSystem = {
  #   system ? "aarch64-darwin",
  #   host,
  # }: let
  #   pkgs = pkgsForSystem system;
  #   inherit (pkgs) lib;
  # in
  #   darwin.lib.darwinSystem {
  #     inherit system;
  #     modules = [
  #       home-manager.darwinModules.home-manager
  #       ../modules/nixos/core/nix.nix
  #       ../darwin/modules
  #       ../hosts/${host}/system.nix
  #       ../modules/home/home-manager.nix
  #       {
  #         # TODO: cleanup
  #         options.modules.user.name = lib.mkOption {
  #           type = lib.types.str;
  #           description = "Default user name";
  #         };
  #       }
  #       {
  #         home-manager.extraSpecialArgs = {
  #           inherit inputs pkgs host;
  #           std = inputs.nix-std.lib;
  #         };
  #       }
  #     ];
  #     specialArgs = {
  #       inherit inputs pkgs host;
  #     };
  #   };
}
