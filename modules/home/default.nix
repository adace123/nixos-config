_: {
  imports = [
    ./desktop
    ./shell
    ./dev
    ./programs
  ];

  # default home packages
  # home.packages = with pkgs; [
  #   home-manager
  #   mdcat
  #   nvd
  #   neovim # uses nixvim overlay
  # ];
}
