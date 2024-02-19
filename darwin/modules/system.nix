_: {
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
    };
  };
}
