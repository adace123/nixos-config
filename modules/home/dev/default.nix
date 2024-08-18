{pkgs, ...}: {
  imports = [./elixir ./go ./python ./rust ./git.nix ./nix.nix ./typescript ./zig ./k8s];
  programs.direnv.enable = true;

  # misc dev packages
  home.packages = with pkgs; [
    # language servers
    lua-language-server
    nixd

    # linters
    tflint
    shellcheck
    yamllint

    # IaC
    pulumi
    terraform

    # DB
    pgcli
  ];
}
