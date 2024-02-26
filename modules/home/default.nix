{pkgs, ...}: {
  imports = [
    ./desktop
    ./shell
    ./dev
    ./programs
  ];

  # default home packages
  home.packages = with pkgs; [
    home-manager
    nvd
    tgpt
  ];
}
