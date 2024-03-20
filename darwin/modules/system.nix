{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    colima
  ];

  system = {
    defaults = {
      dock.autohdide = true;
      dock.mru-spaces = false;
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      screencapture.location = "~/Pictures/screenshots";
      screensaver.askForPasswordDelay = 10;
    };

    keyboard = {
      enableKeyMapping = true;
    };
  };
}
