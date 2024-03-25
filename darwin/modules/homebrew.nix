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
      "wez/wezterm"
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
      "teamviewer"
      "visual-studio-code"
      "warp"
      "wezterm"
      "zoom"
    ];
  };
}
