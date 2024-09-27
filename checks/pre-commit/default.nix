{ inputs, pkgs, ... }:
inputs.pre-commit.lib.${pkgs.system}.run {
  src = ./.;
  hooks = {
    deadnix = {
      enable = true;

      settings = {
        edit = true;
      };
    };

    eslint = {
      enable = true;
      package = pkgs.eslint_d;
    };

    nixfmt-rfc-style.enable = true;

    commitizen.enable = true;

    pre-commit-hook-ensure-sops.enable = true;

  };
}
