{pkgs}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      alejandra
      pulumi
      sops
      ssh-to-age
    ];

    shellHook = ''
      exec ${pkgs.nushell}/bin/nu
    '';
  };
}
