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
      "1password-cli"
      "arc"
      "balenaeetcher"
      "colima"
      "daisydisk"
      "docker"
      "discord"
      "flux"
      "font-fira-code-nerd-font"
      "ollama"
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
