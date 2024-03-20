_: {
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";
    taps = [
      "homebrew/services"
    ];
    brews = [
      "awscli"
      "vault"
    ];
    casks = [
      "1password"
      "1password-cli"
      "arc"
      "balenaetcher"
      "daisydisk"
      "docker"
      "discord"
      "flux"
      "ollama"
      "postman"
      "rapidapi"
      "raycast"
      "slack"
      "spotify"
      "visual-studio-code"
      "warp"
      "zoom"
    ];
  };
}
