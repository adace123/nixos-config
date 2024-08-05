{config, ...}: let
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "SUPER, Q, killactive"
        "SUPER SHIFT, e, exec, sudo systemctl restart greetd"
        "SUPER, f, fullscreen"
        "SUPER SHIFT, f, togglefloating"
        "SUPER SHIFT, r, execr, hyprctl reload"

        # Apps / scripts
        "SUPER, space, exec, rofi -show drun"
        "SUPER, b, exec, ${BROWSER}"
        "SUPER, Return, exec, ${TERMINAL}"
        "SUPER SHIFT, d, exec, discord"
        "SUPER SHIFT, w, exec, pkill waybar && waybar"
        "SUPER SHIFT, m, exec, makoctl dismiss -a"
        "SUPER, c, exec, ${TERMINAL} -e cava"
        "SUPER, y, exec, yt-music"
        "SUPER SHIFT, i, exec, systemd-toggle hypridle --user"
        "SUPER SHIFT, b, exec, ${TERMINAL} -e rebuild"

        # Screenshot
        ",Print, exec,grimblast --notify copysave area"
        "SHIFT, Print, exec,grimblast --notify copy active"
        "CONTROL,Print, exec,grimblast --notify copy screen"
        "SUPER,Print, exec,grimblast --notify copy window"
        "ALT,Print, exec,grimblast --notify copy area"
        "SUPER,bracketleft, exec,grimblast --notify --cursor copysave area ~/Pictures/$(date \" + %Y-%m-%d \"T\"%H:%M:%S_no_watermark \").png"
        "SUPER,bracketright, exec, grimblast --notify --cursor copy area"

        # Focus
        "SUPER,h, movefocus,l"
        "SUPER,l, movefocus,r"
        "SUPER,k, movefocus,u"
        "SUPER,j, movefocus,d"

        # Change Workspace
        "SUPER,1, workspace,01"
        "SUPER,2, workspace,02"
        "SUPER,3, workspace,03"
        "SUPER,4, workspace,04"
        "SUPER,5, workspace,05"
        "SUPER,6, workspace,06"
        "SUPER,7, workspace,07"
        "SUPER,8, workspace,08"
        "SUPER,9, workspace,09"
        "SUPER,0, workspace,10"
        "SUPER,tab, workspace,e+1"
        "SUPER SHIFT,tab, workspace,e-1"

        # Move Workspace
        "SUPER SHIFT,1, movetoworkspacesilent,01"
        "SUPER SHIFT,2, movetoworkspacesilent,02"
        "SUPER SHIFT,3, movetoworkspacesilent,03"
        "SUPER SHIFT,4, movetoworkspacesilent,04"
        "SUPER SHIFT,5, movetoworkspacesilent,05"
        "SUPER SHIFT,6, movetoworkspacesilent,06"
        "SUPER SHIFT,7, movetoworkspacesilent,07"
        "SUPER SHIFT,8, movetoworkspacesilent,08"
        "SUPER SHIFT,9, movetoworkspacesilent,09"
        "SUPER SHIFT,0, movetoworkspacesilent,10"

        # Swap windows
        "SUPER SHIFT,h, swapwindow,l"
        "SUPER SHIFT,l, swapwindow,r"
        "SUPER SHIFT,k, swapwindow,u"
        "SUPER SHIFT,j, swapwindow,d"

        # Sratchpad
        "SUPER, equal, exec, pypr toggle terminal"
        "SUPER ALT, b, exec, pypr toggle btop"
        "SUPER ALT, t, exec, pypr toggle tgpt"
        "SUPER ALT, y, exec, pypr toggle yazi"
        "SUPER ALT, k, exec, pypr toggle k9s"
        "SUPER ALT, w, exec, pypr toggle wallpaper-picker"

        # Submaps
        "SUPER SHIFT, s, submap, system"

        # resize
        "SUPER ALT, h, resizeactive, -30 0"
        "SUPER ALT, l, resizeactive, 30 0"
        "SUPER ALT, k, resizeactive, 0 -30"
        "SUPER ALT, j, resizeactive, 0 30"
      ];

      bindle = [
        # Media
        "SUPER, p, exec, playerctl play-pause"
        "SUPER SHIFT, p, exec, playerctl stop"
        "SUPER, v, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "SUPER SHIFT, v, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "SUPER, m, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioStop, exec, playerctl stop"
      ];
    };

    extraConfig = ''
      submap = system
      bind = , r, execr, systemctl reboot
      bind = , p, execr, systemctl poweroff -i
      bind = , s, execr, systemctl suspend
      bind = , l, exec, hyprctl dispatch submap reset && hyprlock
      bind = , L, exec, hyprctl dispatch exit
      bind = , Return, submap, reset
      bind = , Escape, submap, reset
      bind = CTRL, C, submap, reset
      submap = reset
    '';
  };
}
