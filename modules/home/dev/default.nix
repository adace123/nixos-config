{...}: {
  imports = [./elixir ./go ./python ./rust ./git.nix ./typescript ./zig ./k8s];
  programs.direnv.enable = true;
}
