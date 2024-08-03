{
  self,
  pkgs,
}: {
  default = pkgs.mkShell {
    inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;
    nativeBuildInputs = with pkgs;
      [
        ssh-to-age
      ]
      ++ self.checks.${pkgs.system}.pre-commit-check.enabledPackages;
  };
}
