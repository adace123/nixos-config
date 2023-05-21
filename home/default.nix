{
  inputs,
  nixpkgs,
  system ? "x86_64-linux",
  ...
}: let
  mkHome = username: isDesktop:
    inputs.home-manager.lib.homeManagerConfiguration rec {
      pkgs = import nixpkgs {inherit system;};
      modules =
        [
          ./profiles/common
        ]
        ++ (pkgs.lib.optional isDesktop ./profiles/desktop);
      extraSpecialArgs = {
        inherit inputs username;
      };
    };
in {
  aaron = mkHome "aaron" true;
}
