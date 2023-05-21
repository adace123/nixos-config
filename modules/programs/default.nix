{lib, ...}: with lib; {
  imports = [
    ./terminal
  ];

  home = {
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
  };
}
