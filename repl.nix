let
  flake = builtins.getFlake (toString ./.);
in
  flake
  // {
    pkgs = import flake.inputs.nixpkgs {system = builtins.currentSystem;};
  }
