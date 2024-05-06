# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = final: _:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    }
    // {
      zjstatus = inputs.zjstatus.packages.${final.system}.default;
    };

  modifications = _: prev: let
    mkPackage = path:
      prev.callPackage path {
        inherit inputs;
        pkgs = prev;
      };
  in {
    tgpt = mkPackage ./tgpt.nix;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
