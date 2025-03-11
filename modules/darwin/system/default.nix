{ lib, pkgs, ... }:
with lib;
{
  imports = [
    (snowfall.fs.get-file "modules/shared/suites/common/default.nix")
  ];

  users.users.aaron = {
    home = "/Users/aaron";
    shell = pkgs.nushell;
  };

  networking = {
    # get via `networksetup -listallnetworkservices`
    knownNetworkServices = [ "Wi-Fi" ];
    dns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
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
        AppleInterfaceStyle = "Dark";
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
