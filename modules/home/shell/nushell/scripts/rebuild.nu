def main [--verbose (-v)] {
  notify-send "Rebuilding system..."
  try {
    if $verbose {
        /run/wrappers/bin/sudo nixos-rebuild switch --flake $"($env.DOTFILES_DIR)#(hostname)" --show-trace
    } else {
        /run/wrappers/bin/sudo nixos-rebuild switch --flake $"($env.DOTFILES_DIR)#(hostname)"
    }
  } catch {
    notify-send -u critical "Failed to rebuild!"
    return
  }

  if $env.LAST_EXIT_CODE == 0 {
    notify-send "Finished rebuilding"
  } else {
    notify-send -u critical "Failed to rebuild!"
  }
}
