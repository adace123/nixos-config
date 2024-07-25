def main [--verbose (-v)] {
  if ((uname | get kernel-name) == "Darwin") {
    darwin-rebuild switch --flake .#endor
  } else {
    notify-send "Rebuilding system..."
    try {
      if $verbose {
          nh os switch -v $env.DOTFILES_DIR
      } else {
          nh os switch $env.DOTFILES_DIR
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
}
