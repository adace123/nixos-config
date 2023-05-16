{...}: {
  imports = [
    ./alacritty
  ];

  home = {
    sessionVariables = {
      TERMINAL = "alacritty";
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
  };
}
