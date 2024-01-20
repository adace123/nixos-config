# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = final: _:
    import ../pkgs {
      pkgs = final;
      inherit inputs;
    };

  modifications = _: prev: {
    nushell = prev.nushell.override {additionalFeatures = p: p ++ ["dataframe"];};
    talosctl = prev.talosctl.override {buildGoModule = prev.buildGo120Module;};
    neovim = inputs.neovim-flake.packages.${prev.system}.default;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
