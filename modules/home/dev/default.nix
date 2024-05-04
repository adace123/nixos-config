{pkgs, ...}: {
  imports = [./elixir ./go ./python ./rust ./git.nix ./typescript ./zig ./k8s];
  programs.direnv.enable = true;

  # misc dev packages
  home.packages = with pkgs; [
    # language servers
    lua-language-server
    nixd

    # formatters
    alejandra
    stylua
    yamlfmt
    shfmt

    # linters
    yamllint
    shellcheck

    # IaC
    pulumi
  ];
}
