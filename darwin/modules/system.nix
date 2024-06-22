{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    colima
    coreutils
  ];

  environment.loginShell = pkgs.nushell;

  system = {
    defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      screencapture.location = "~/Pictures/screenshots";
      screensaver.askForPasswordDelay = 10;

      trackpad = {Clicking = true;};
      NSGlobalDomain = {
        # tap to click
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.swipescrolldirection" = false;
      };
    };

    keyboard = {
      enableKeyMapping = true;
    };
  };
}
