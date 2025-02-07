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
      caligula # disk imaging
    ]
    ++ inputs.self.checks.${pkgs.system}.pre-commit.enabledPackages
    ++ (pkgs.lib.optional pkgs.stdenv.isDarwin inputs.darwin.packages.${pkgs.system}.default);

  shellHook = ''
    ${inputs.self.checks.${pkgs.system}.pre-commit.shellHook}
  '';
}
