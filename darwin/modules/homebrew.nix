_: {
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    taps = [
      "wez/wezterm"
    ];
    brews = [
      "awscli"
    ];
    casks = [
      "1password"
      "arc"
      "balenaeetcher"
      "colima"
      "docker"
      "discord"
      "flux"
      "font-fira-code-nerd-font"
      "postman"
      "raycast"
      "slack"
      "spotify"
      "visual-studio-code"
      "warp"
      "wezterm" # avoid failing build in programs.wezterm
      "zoom"
    ];
  };
}
