# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = pkgs: _:
    import ../pkgs {
      inherit inputs pkgs;
    }
    // {
      kittyScrollback = import ./kitty-scrollback.nix {inherit pkgs;};
    };

  modifications = _: _: let
    # mkPackage = path:
    #   prev.callPackage path {
    #     inherit inputs;
    #     pkgs = prev;
    #   };
  in {
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
