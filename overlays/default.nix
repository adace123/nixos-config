# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = final: _:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    };

  modifications = final: prev: {
    nushell = prev.nushell.override {additionalFeatures = p: p ++ ["dataframe"];};
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
