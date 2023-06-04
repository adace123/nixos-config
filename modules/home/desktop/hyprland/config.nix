{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  inherit (config.modules.desktop) monitor;
  inherit (config.modules.desktop) wallpaper;
  inherit (config.home.sessionVariables) TERMINAL BROWSER EDITOR;

  genSubmap = name: binds: let
    bindType =
      if name == "resize"
      then "binde"
      else "bind";
  in ''
    submap = ${name}
    ${builtins.concatStringsSep "\n" (builtins.map (bind: "${bindType} = ${bind}") binds)}
    bind = , Return, submap, reset
    submap = reset
  '';

  hyprConfig = rec {
    mod = "SUPER";

    exec-once = [
      "${TERMINAL}"
      "hyprctl setcursor Bibata-Modern-Classic 24"
    ];

    display = "${monitor.output}, ${monitor.resolution}, 0x0, 1";

    input = ''
      kb_layout = us
    '';

    general = ''
      sensitivity = 1.0
      gaps_in = 8
      gaps_out = 10
      border_size = 3
      col.active_border=0xff${config.colorScheme.colors.base0C}
      col.inactive_border=0xff${config.colorScheme.colors.base02}
      col.group_border_active=0xff${config.colorScheme.colors.base0B}
      col.group_border=0xff${config.colorScheme.colors.base04}
      apply_sens_to_raw = 0
    '';

    decoration = ''
      active_opacity=0.94
      inactive_opacity=0.84
      fullscreen_opacity=1.0
      rounding=5
      blur=true
      blur_size=5
      blur_passes=3
      blur_new_optimizations=true
      blur_ignore_opacity=true
      drop_shadow=true
      shadow_range=12
      shadow_offset=3 3
      col.shadow=0x44000000
      col.shadow_inactive=0x66000000
    '';

    animations = ''
      enabled = true
      bezier = overshot, 0.13, 0.99, 0.29, 1.1
      animation = windows, 1, 4, overshot, slide
      animation = border, 1, 10, default
      animation = fade, 1, 10, default
      animation = workspaces, 1, 6, overshot, slidevert
    '';

    dwindle = ''
      pseudotile = 1
      force_split = 0
    '';

    binds = {
      main = [
        "${mod}, q, killactive"
        "${mod} SHIFT, r, execr, hyprctl reload"
        "${mod} SHIFT, e, exit"
      ];

      apps = [
        "${mod}, w, exec, ${BROWSER}"
        "${mod}, Return, exec, ${TERMINAL}"
      ];

      window = [
        "${mod} SHIFT, Space, togglefloating"
        "${mod}, A, togglesplit"
        "${mod}, f, fullscreen"
      ];

      navigation = [
        "${mod}, left, movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up, movefocus, u"
        "${mod}, down, movefocus, d"
        "${mod}, h, movefocus, l"
        "${mod}, l, movefocus, r"
        "${mod}, k, movefocus, u"
        "${mod}, j, movefocus, d"
        "${mod} SHIFT, left, swapwindow, l"
        "${mod} SHIFT, right, swapwindow, r"
        "${mod} SHIFT, up, swapwindow, u"
        "${mod} SHIFT, down, swapwindow, d"
        "${mod} SHIFT, h, swapwindow, l"
        "${mod} SHIFT, l, swapwindow, r"
        "${mod} SHIFT, k, swapwindow, u"
        "${mod} SHIFT, j, swapwindow, d"
      ];

      media = [
        "${mod} SHIFT, p, exec, playerctl play-pause"
        "${mod} SHIFT, plus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "${mod} SHIFT, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      workspace = let
        numberedBinds =
          builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in ''
              ${mod}, ${ws}, workspace, ${toString (x + 1)}
              bind = ${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            ''
          )
          10;
      in
        [
          "${mod}, tab, workspace, e+1"
          "${mod} SHIFT, tab, workspace, e-1"
        ]
        ++ numberedBinds;

      scratchpad = [
        "${mod} SHIFT, s, movetoworkspace, special"
        "${mod}, s, togglespecialworkspace"
      ];

      activateModes = [
        "ALT SHIFT, r, submap, resize"
        "ALT SHIFT, s, submap, system"
      ];

      modes = {
        resize = [
          ", right, resizeactive, 10 0"
          ", left, resizeactive, -10 0"
          ", up, resizeactive, 0 -10"
          ", down, resizeactive, 0 10"
          ", l, resizeactive, 10 0"
          ", h, resizeactive, -10 0"
          ", k, resizeactive, 0 -10"
          ", j, resizeactive, 0 10"
        ];

        system = [
          ", r, execr, systemctl reboot"
          ", s, execr, systemctl poweroff -i"
          ", l, exec, gtklock"
        ];
      };
    };

    mainBinds = with binds; main ++ workspace ++ media ++ activateModes ++ scratchpad ++ navigation ++ window ++ apps;

    submaps = with binds.modes;
      builtins.concatStringsSep "\n" [
        (genSubmap "resize" resize)
        (genSubmap "system" system)
      ];
  };
in
  with lib; {
    config = mkIf cfg.enable {
      xdg.configFile."hypr/hyprland.conf".text = with hyprConfig; ''
          $mod = ${mod}

        ${builtins.concatStringsSep "\n" (map (exec: "exec-once = ${exec}") exec-once)}

        monitor = ${display}

        input {
          ${input}
        }

        general {
          ${general}
        }

        decoration {
          ${decoration}
        }

        animations {
          ${animations}
        }

        dwindle {
          ${dwindle}
        }

        ${builtins.concatStringsSep "\n" (map (bind: "bind = ${bind}") mainBinds)}

        ${submaps}
      '';
    };
  }
