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
      "docker"
      "docker-credential-helper"
      "gsed"
      "qemu"
      "vault"
    ];
    casks = [
      "1password"
      "1password-cli"
      "arc"
      "balenaetcher"
      "chatgpt"
      "docker"
      "discord"
      "flux"
      "ghostty" # TODO: Use nixpkgs instead
      "hammerspoon"
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
