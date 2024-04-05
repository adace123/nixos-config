{pkgs, ...}: let
  weather_command = "http get https://wttr.in/Los_Angeles?format=%c%t%20Los_Angeles";
in ''
  layout {
      default_tab_template {
          children
          pane size=1 borderless=true {
              plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                  format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                  format_center "{tabs}"
                  format_right  "{command_weather} {datetime}"
                  format_space  ""

                  border_enabled  "true"
                  border_char     "─"
                  border_format   "#[fg=#6C7086]{char}"
                  border_position "top"

                  hide_frame_for_single_pane "true"

                  mode_normal  "#[bg=blue] "
                  mode_pane    "#[fg=purple] PANE "
                  mode_tab     "#[fg=red] TAB "
                  mode_resize  "#[fg=red] RESIZE "
                  mode_tmux    "#[bg=#ffc387] "

                  tab_normal   "#[fg=#6C7086] {name} "
                  tab_active   "#[fg=#9399B2,bold,italic] {name} "

                  command_weather_command "nu -c \"${weather_command}\""
                  command_weather_format "{stdout}"
                  command_weather_interval "750"
                  command_weather_rendermode  "static"

                  datetime        "#[fg=#6C7086,bold] {format} "
                  datetime_format "%A, %d %b %Y %H:%M"
                  datetime_timezone "America/Los_Angeles"
              }
          }
      }
  }
''
