let
  flake = builtins.getFlake (toString ./.);
in
flake
// {
  pkgs = import flake.inputs.nixpkgs { system = builtins.currentSystem; };
  endor-hm = flake.darwinConfigurations.endor.config.home-manager.users.aaron;
}
