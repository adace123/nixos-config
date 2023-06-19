# credit: https://github.com/rxyhn/yuki
{inputs}: let
  additions = final: _: import ../pkgs {pkgs = final;};
in {
  default = final: prev: (additions final prev);
}
