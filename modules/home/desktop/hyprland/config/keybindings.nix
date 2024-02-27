{
  pkgs,
  config,
  ...
}: let
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
in {
  wayland.windowManager.hyprland.settings = {
    bind = {
      "SUPER, Q" = "killactive";
      "SUPERHSHIFT, e" = "exit";
      "SUPER, f" = "fullscreen";
      "SUPERSHIFT, f" = "togglefloating";
      "SUPERSHIFT, r" = "execr, hyprctl reload";

      # Apps / scripts
      "SUPER, a" = "exec rofi -show drun -mode drun";
      "SUPER, b" = "exec, ${BROWSER}";
      "SUPER, Return" = "exec, ${TERMINAL}";
      "SUPER, d" = "exec, discord";
      "SUPERHSHIFT, w" = "exec, pkill waybar && waybar";
      "SUPERSHIFT, d" = "exec, makoctl dismiss";
      "SUPER, c" = "exec, ${TERMINAL} -e cava";
      "SUPER, y" = "exec, yt-music";
      "SUPERSHIFT, i" = "exec, systemd-toggle hypridle --user";
      "SUPERSHIFT, b" = "exec, ${TERMINAL} -e rebuild";

      # Screenshot
      ",Print" = "exec,grimblast --notify copysave area";
      "SHIFT, Print" = "exec,grimblast --notify copy active";
      "CONTROL,Print" = "exec,grimblast --notify copy screen";
      "SUPER,Print" = "exec,grimblast --notify copy window";
      "ALT,Print" = "exec,grimblast --notify copy area";
      "SUPER,bracketleft" = "exec,grimblast --notify --cursor copysave area ~/Pictures/$(date \" + %Y-%m-%d \"T\"%H:%M:%S_no_watermark \").png";
      "SUPER,bracketright" = "exec, grimblast --notify --cursor copy area";

      # Focus
      "SUPER,h" = "movefocus,l";
      "SUPER,l" = "movefocus,r";
      "SUPER,k" = "movefocus,u";
      "SUPER,j" = "movefocus,d";

      # Change Workspace
      "SUPER,1" = "workspace,01";
      "SUPER,2" = "workspace,02";
      "SUPER,3" = "workspace,03";
      "SUPER,4" = "workspace,04";
      "SUPER,5" = "workspace,05";
      "SUPER,6" = "workspace,06";
      "SUPER,7" = "workspace,07";
      "SUPER,8" = "workspace,08";
      "SUPER,9" = "workspace,09";
      "SUPER,0" = "workspace,10";
      "SUPER,tab" = "workspace,e+1";
      "SUPERSHIFT,tab" = "workspace,e-1";

      # Move Workspace
      "SUPERSHIFT,1" = "movetoworkspacesilent,01";
      "SUPERSHIFT,2" = "movetoworkspacesilent,02";
      "SUPERSHIFT,3" = "movetoworkspacesilent,03";
      "SUPERSHIFT,4" = "movetoworkspacesilent,04";
      "SUPERSHIFT,5" = "movetoworkspacesilent,05";
      "SUPERSHIFT,6" = "movetoworkspacesilent,06";
      "SUPERSHIFT,7" = "movetoworkspacesilent,07";
      "SUPERSHIFT,8" = "movetoworkspacesilent,08";
      "SUPERSHIFT,9" = "movetoworkspacesilent,09";
      "SUPERSHIFT,0" = "movetoworkspacesilent,10";

      # Swap windows
      "SUPERSHIFT,h" = "swapwindow,l";
      "SUPERSHIFT,l" = "swapwindow,r";
      "SUPERSHIFT,k" = "swapwindow,u";
      "SUPERSHIFT,j" = "swapwindow,d";

      # Sratchpad
      "SUPER, equal" = "exec, pypr toggle terminal";
      "SUPER ALT, b" = "exec, pypr toggle btm";

      # Submaps
      "SUPERSHIFT, s" = "submap, system";
    };

    bindi = {
      ",XF86MonBrightnessUp" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl +5%";
      ",XF86MonBrightnessDown" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl -5% ";
      ",XF86AudioRaiseVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      ",XF86AudioLowerVolume" = "exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      ",XF86AudioMute,exec" = "exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      ",XF86AudioMicMute" = "exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute";
      ",XF86AudioNext" = "exec, playerctl next";
      ",XF86AudioPrev" = "exec, playerctl previous";
      ",XF86AudioPlay" = "exec, playerctl play-pause";
      ",XF86AudioStop" = "exec, playerctl stop";
    };

    binde = {
      "SUPERALT, h" = "resizeactive, -20 0";
      "SUPERALT, l" = "resizeactive, 20 0";
      "SUPERALT, k" = "resizeactive, 0 -20";
      "SUPERALT, j" = "resizeactive, 0 20";
    };

    extraConfig = ''
      submap = resize
      bind = , r, execr, systemctl reboot
      bind = , p, execr, systemctl poweroff -i
      bind = , s, execr, systemctl suspend
      bind = , l, exec, hyprctl dispatch submap reset && hyprlock
      submap = reset
    '';
  };
}
