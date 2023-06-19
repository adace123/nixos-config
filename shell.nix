{pkgs}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      alejandra
      statix
      sops
      ssh-to-age
    ];
  };
}
