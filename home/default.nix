{
  inputs,
  nixpkgs,
  system ? "x86_64-linux",
  ...
}: let
  mkHome = username:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      modules = [
        ./users/${username}
      ];
      extraSpecialArgs = {
        inherit inputs username;
      };
    };
in {
  aaron = mkHome "aaron";
}
