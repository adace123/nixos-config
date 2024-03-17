{pkgs, ...}: {
  imports = [./firefox ./amfora ./qutebrowser];
  xdg.mimeApps.enable = pkgs.system != "x86_64-darwin";
}
