{
  self,
  pkgs,
  inputs,
  ...
}: let
  isDarwin = (builtins.match ".*darwin" pkgs.system) != null;
  inherit (inputs.darwin.packages.${pkgs.system}) darwin-rebuild;
in {
  default = pkgs.mkShell {
    inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;
    nativeBuildInputs = with pkgs;
      [
        alejandra
        sops
        ssh-to-age
        just
        gh
        pulumi-bin
        home-manager
      ]
      ++ (pkgs.lib.optional isDarwin darwin-rebuild);
  };
}
