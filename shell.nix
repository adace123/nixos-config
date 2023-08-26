{pkgs}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      alejandra
      pulumi
      pulumiPackages.pulumi-language-nodejs
      sops
      ssh-to-age
    ];

    shellHook = ''
      exec ${pkgs.nushell}/bin/nu
    '';
  };
}
