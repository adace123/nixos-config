_: {
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      upgrade = true;
      cleanup = "zap";
      autoUpdate = false;
    };
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
      "obsidian"
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
