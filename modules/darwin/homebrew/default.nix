_: {
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
      autoUpdate = true;
    };
    taps = [
      "homebrew/services"
      "homebrew/bundle"
    ];
    brews = [
      "awscli"
      "colima"
      "gsed"
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
      "microsoft-teams"
      "notion"
      "obsidian"
      "ollama"
      "postman"
      "rapidapi"
      "raycast"
      "slack"
      "spotify"
      "teamviewer"
      "warp"
      "zoom"
    ];
  };
}
