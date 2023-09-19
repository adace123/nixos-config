{
  self,
  pkgs,
}: {
  default = pkgs.mkShell {
    inherit (self.checks.${pkgs.system}.pre-commit-check) shellHook;
    nativeBuildInputs = with pkgs; [
      alejandra
      pulumi
      pulumiPackages.pulumi-language-nodejs
      sops
      ssh-to-age
    ];
  };
}
