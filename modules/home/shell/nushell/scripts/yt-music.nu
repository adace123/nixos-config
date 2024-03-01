def main [] {
  let streams = {
    "Synthwave": "4xDzrJKXOOY",
    "Chillhop": "5yx6BWlEVcY",
    "Post-Rock": "MRhplCpkPKE",
    "Space Ambient": "E5WpblyBR38",
    "Classical": "tSlOlKRuudU",
    "Chillstep": "QxtigSvGnD8",
    "Cyberpunk": "xulXmZrC9uI"
  }
  let selected_stream = $streams | columns | str join "\n" | rofi -i -dmenu -p "Select music stream"
  if ($selected_stream == "") {
    exit 0
  }

  let yt_id = $streams | get $selected_stream
  try {
    playerctl stop
  } catch {}

  notify-send $"Playing ($selected_stream)"
  hyprctl dispatch exec $'mpv --no-video "https://youtube.com/watch?v=($yt_id)"'
}
