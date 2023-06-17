{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.waybar;
in
  with lib; {
    options.modules.desktop.waybar.enable = mkEnableOption "waybar";

    config = mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oa: {
          mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
        });
        systemd = {
          enable = true;
          target = "hyprland-session.target";
        };
        style = builtins.readFile ./style.css;
        settings = {
          mainBar = {
            height = 40;
            spacing = 4;
            "modules-left" = [
              "wlr/workspaces"
            ];
            "modules-center" = [
              "clock"
              "hyprland/window"
              "hyprland/submap"
            ];
            "modules-right" = [
              "wireplumber"
              "cpu"
              "memory"
              "network"
              "disk"
            ];
            "wlr/workspaces" = {
              format-icons = {
                default = "";
              };
              format = "{name}";
              all-outputs = true;
              on-click = "activate";
              active-only = false;
              disable-scroll = false;
              on-scroll-up = "hyprctl dispatch workspace -1";
              on-scroll-down = "hyprctl dispatch workspace +1";
              sort-by-number = true;
            };
            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            clock = {
              format = "{:%b %d; %Y | %H:%M}  ";
              format-alt = "{:%A, %B %d, %Y (%R)}  ";
              timezone = "America/Los_Angeles";
            };
            cpu = {
              format = "{usage}% ";
              tooltip = false;
            };
            memory = {
              format = "{percentage}% ";
            };
            "disk" = {
              "format" = "{used} / {total} ";
            };
            "hyprland/submap" = {
              format = "  {}";
            };
            backlight = {
              format = "{percent}% {icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
              ];
            };
            battery = {
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% ";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };
            network = {
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} ";
              tooltip-format = "{ifname} via {gwaddr} ";
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "Disconnected ⚠";
              format-alt = "{ifname}= {ipaddr}/{cidr}";
            };
            pulseaudio = {
              format = "{volume}% {icon} {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = " {format_source}";
              format-source = "{volume}% ";
              format-source-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                ];
              };
              on-click = "pavucontrol";
            };
            wireplumber = {
              format = "{volume}% {node_name} {icon}";
              format-muted = "";
              format-icons = [
                ""
                ""
                ""
              ];
            };
          };
        };
      };
    };
  }