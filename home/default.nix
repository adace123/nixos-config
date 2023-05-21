{
  home-manager,
  inputs,
  nixpkgs,
  lib,
  system ? "x86_64-linux",
  ...
}: let
  mkHome = username: isDesktop:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      modules =
        [
          ./profiles/common
        ]
        ++ (lib.optional isDesktop [./profiles/desktop]);
      extraSpecialArgs = {
        inherit inputs username;
      };
    };
in {
  aaron = mkHome "aaron" true;
}
