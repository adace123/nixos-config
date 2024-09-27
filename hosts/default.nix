{
  inputs,
  overlays,
  ...
}:
let
  myLib = import ../lib { inherit inputs overlays; };
in
with myLib;
{
  nixosConfigurations = {
    coruscant = mkNixosSystem { host = "coruscant"; };
    # The full system is too large to install via nixos-anywhere
    # Need to install a minimal version first
    coruscant-minimal = mkNixosSystem {
      host = "coruscant";
      fullBuild = false;
    };
    iso = mkNixosSystem { host = "iso"; };
  };
  darwinConfigurations = {
    endor = mkDarwinSystem {
      # TODO: update to aarch64-darwin
      system = "aarch64-darwin";
      host = "endor";
    };
  };
}
