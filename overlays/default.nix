# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = final: _:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    };

  modifications = _: prev: {
    nushell = prev.nushell.override {additionalFeatures = p: p ++ ["dataframe"];};
    neovim = inputs.neovim-flake.packages.${prev.system}.default;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
