{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.desktop.window-managers.aerospace;
  format = pkgs.formats.toml { };
  configFile = format.generate "aerospace.toml" {
    gaps = {
      outer.top = 8;
      outer.right = 8;
      outer.bottom = 8;
      outer.left = 8;
      inner.horizontal = 8;
      inner.vertical = 8;
    };

    default-root-container-layout = "tiles";
    default-root-container-orientation = "auto";

    on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
    mode.main.binding = {
      alt-1 = "workspace Arc";
      alt-2 = "workspace Ghostty";
      alt-3 = "workspace Discord";
      alt-4 = "workspace 1Password";
      alt-5 = "workspace Obsidian";
      alt-6 = "workspace Zen";
      alt-7 = "workspace Zed";

      alt-shift-1 = [
        "move-node-to-workspace Arc"
        "workspace Arc"
      ];
      alt-shift-2 = [
        "move-node-to-workspace Ghostty"
        "workspace Ghostty"
      ];
      alt-shift-3 = [
        "move-node-to-workspace Discord"
        "workspace Discord"
      ];
      alt-shift-4 = [
        "move-node-to-workspace 1Password"
        "workspace 1Password"
      ];
      alt-shift-5 = [
        "move-node-to-workspace Obsidian"
        "workspace Obsidian"
      ];
      alt-shift-6 = [
        "move-node-to-workspace Zen"
        "workspace Zen"
      ];
      alt-shift-7 = [
        "move-node-to-workspace Zed"
        "workspace Zed"
      ];

      alt-h = "focus left";
      alt-j = "focus down";
      alt-k = "focus up";
      alt-l = "focus right";

      "alt-shift-semicolon" = "mode service";

      # See: https://nikitabobko.github.io/AeroSpace/commands#resize
      alt-shift-minus = "resize smart -50";
      alt-shift-equal = "resize smart +50";

      # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
      alt-tab = "workspace-back-and-forth";

      alt-comma = "workspace prev";
      alt-period = "workspace next";

      alt-slash = "layout tiles horizontal vertical";
      alt-backslash = "layout accordion horizontal vertical";

      alt-q = "close";

      # Switch to resize mode
      alt-r = "mode resize";

      alt-f = "macos-native-fullscreen";

      alt-enter = "exec-and-forget open -n -a ghostty";

      alt-shift-tab = [
        "move-node-to-monitor --wrap-around next"
        "focus-monitor --wrap-around next"
      ];

      alt-shift-space = "layout floating tiling";
    };

    mode.resize.binding = {
      # Resize the window
      h = "resize width -50";
      j = "resize height +50";
      k = "resize height -50";
      l = "resize width +50";
      enter = "mode main";
      esc = "mode main";
    };

    mode.service.binding = {
      # Join with adjacent windows
      alt-shift-h = [
        "join-with left"
        "mode main"
      ];
      alt-shift-j = [
        "join-with down"
        "mode main"
      ];
      alt-shift-k = [
        "join-with up"
        "mode main"
      ];
      alt-shift-l = [
        "join-with right"
        "mode main"
      ];
    };

    on-window-detected = [
      {
        "if".app-id = "company.thebrowser.Browser";
        run = [
          "move-node-to-workspace Arc"
        ];
      }
      {
        "if".app-id = "com.mitchellh.ghostty";
        run = [ "move-node-to-workspace Ghostty" ];
      }
      {
        "if".app-id = "com.hnc.Discord";
        run = [ "move-node-to-workspace Discord" ];
      }
      {
        "if".app-id = "com.1password.1password";
        run = [ "move-node-to-workspace 1Password" ];
      }
      {
        "if".app-id = "dev.zed.Zed";
        run = [ "move-node-to-workspace Zed" ];
      }
      {
        "if".app-id = "org.mozilla.com.zen.browser";
        run = [ "move-node-to-workspace Zen" ];
      }
      {
        "if".app-id = "obsidian.id";
        run = [ "move-node-to-workspace Obsidian" ];
      }
    ];
  };
in
with lib;
{
  options.adace.desktop.window-managers.aerospace.enable =
    mkEnableOption "aerospace tiling window manager";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.aerospace ];

    launchd.user.agents.aerospace = {
      command = "${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace --config-path ${configFile}";
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
