{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    colima
  ];

  environment.loginShell = pkgs.nushell;

  fonts.fonts = with pkgs; [
    material-symbols
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "GeistMono"];})
    font-awesome
    fira-code-symbols
    source-code-pro
  ];

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
    };

    keyboard = {
      enableKeyMapping = true;
    };
  };
}
