{pkgs, ...}: {
  imports = [./firefox ./amfora ./qutebrowser];
  xdg.mimeApps.enable = pkgs.system != "aarch64-darwin";
}
