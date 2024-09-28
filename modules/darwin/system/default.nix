{ lib, ... }:
{
  imports = [ (lib.snowfall.fs.get-file "modules/shared/suites/common/default.nix") ];
  system = {
    stateVersion = 5;
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

      trackpad = {
        Clicking = true;
      };
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