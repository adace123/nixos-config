{
  osConfig,
  config,
  pkgs,
  ...
}: let
  inherit (config.modules.desktop) monitor;
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
  mod = "SUPER";
  genSubmap = name: binds: let
    bindType =
      if name == "resize"
      then "binde"
      else "bind";
  in ''
    submap = ${name}
    ${builtins.concatStringsSep "\n" (builtins.map (bind: "${bindType} = ${bind}") binds)}
    bind = , Return, submap, reset
    bind = , Escape, submap, reset
    bind = CTRL, C, submap, reset
    submap = reset
  '';
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = mod;
      general = {
        sensitivity = 1.0;
        gaps_in = 8;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "0xff9b5de5";
        "col.inactive_border" = "0xff${config.colorScheme.palette.base02}";
      };

      decoration = {
        active_opacity = 0.90;
        inactive_opacity = 0.84;
        fullscreen_opacity = 1.0;
        rounding = 5;
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
        "col.shadow" = "0x44000000";
        "col.shadow_inactive" = "0x66000000";
      };

      animations = {
        enabled = true;
        bezier = ["overshot, 0.13, 0.99, 0.29, 1.1"];
        animation = [
          "windows, 1, 4, overshot, slide"
          "border, 1, 10, default"
          "fade, 1, 10, default"
          "workspaces, 1, 6, overshot, slidevert"
        ];
      };

      dwindle = {
        pseudotile = 1;
        force_split = 0;
      };

      monitor = ["${monitor.output}, ${monitor.resolution}, 0x0, 1"];

      exec-once = [
        "${TERMINAL}"
        "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        "${TERMINAL} --class scratchpad"
        "${BROWSER}"
        "pypr"
      ];

      bind = let
        main = [
          "${mod}, q, killactive"
          "${mod} SHIFT, r, execr, hyprctl reload"
          "${mod} SHIFT, e, exit"
        ];

        apps = [
          "${mod}, b, exec, ${BROWSER}"
          "${mod}, Return, exec, ${TERMINAL}"
          "${mod} SHIFT, i, exec, systemd-toggle hypridle --user"
          "${mod} SHIFT, b, exec, ${TERMINAL} -e rebuild"
          "${mod} SHIFT, d, exec, makoctl dismiss -a"
          "${mod}, SPACE, exec, rofi -show drun"
          "${mod}, d, exec, discord"
          "${mod}, c, exec, ${TERMINAL} -e cava"
          "SHIFT, Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copy screen"
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copy area"
          "ALT, Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copy active"
          "${mod} SHIFT, w, exec, pkill waybar && waybar" # reload waybar
        ];

        window = [
          "${mod} SHIFT, f, togglefloating"
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
          "${mod}, p, exec, playerctl play-pause"
          "${mod} SHIFT, v, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          "${mod}, v, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "${mod}, m, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];

        scratchpad = [
          "${mod}, equal, exec, pypr toggle terminal"
          "${mod} ALT, b, exec, pypr toggle btm"
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

        activateModes = [
          "${mod} SHIFT, r, submap, resize"
          "${mod} SHIFT, s, submap, system"
        ];
      in
        main ++ apps ++ window ++ navigation ++ media ++ scratchpad ++ workspace ++ activateModes;

      windowrulev2 = [
        "opacity 1.0 override 1.0 override,class:^(firefox)$"
        "opacity 1.0 override 1.0 override,class:^(qutebrowser)$"
        "workspace special silent, class:^(scratchpad)$"
        "float, class:^(scratchpad)$"
        "center, class:^(scratchpad)$"
        "size 80% 85%, class:^(scratchpad)$"
      ];
    };
    extraConfig = let
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
          ", p, execr, systemctl poweroff -i"
          ", s, execr, systemctl suspend"
          ", l, exec, hyprctl dispatch submap reset && hyprlock"
        ];
      };
      submaps = with modes;
        builtins.concatStringsSep "\n" [
          (genSubmap "resize" resize)
          (genSubmap "system" system)
        ];
    in ''
      env = DOTFILES_DIR,/home/${osConfig.modules.user.name}/nixos-config
      ${submaps}
    '';
  };
}
