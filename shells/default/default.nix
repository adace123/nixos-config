{
  inputs,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages =
    with pkgs;
    [
      just
      home-manager
      pulumi-bin
      ssh-to-age
    ]
    ++ inputs.self.checks.${pkgs.system}.pre-commit.enabledPackages;

  shellHook = ''
    ${inputs.self.checks.${pkgs.system}.pre-commit.shellHook}
  '';
}
