{
  self,
  pkgs,
}: {
  default = pkgs.mkShell {
    inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;
    nativeBuildInputs = with pkgs; [
      alejandra
      sops
      ssh-to-age
    ];
  };
}
