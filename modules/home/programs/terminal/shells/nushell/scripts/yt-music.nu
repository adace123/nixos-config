def main [] {
  let streams = {
    "Synthwave": "4xDzrJKXOOY",
    "Chillhop": "5yx6BWlEVcY",
    "Post-Rock": "MRhplCpkPKE",
    "Space Ambient": "E5WpblyBR38",
    "Classical": "y6TZHLAzg5o",
    "Chillstep": "QxtigSvGnD8",
    "Cyberpunk": "xulXmZrC9uI",
    "Dark Ambient": "nohM0W27xus",
    "Progressive House": "6Q7tdD5lJxg",
  }
  let selected_stream = $streams | columns | str join "\n" | rofi -dmenu -i -P "Select stream"
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
