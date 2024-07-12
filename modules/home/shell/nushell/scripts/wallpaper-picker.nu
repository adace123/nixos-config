def fetch-apod [] {
  let img_url = http get https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY | get hdurl
  http get $img_url | swww img -
}

def main [--mode: string = "rofi"] {
  # fast transition
  $env.SWWW_TRANSITION_STEP = 25

  if $mode == "apod" {
    fetch-apod
    return
  }

  let file_choices = (ls -la "~/Pictures/wallpapers"
  | where {|x| $x.type == "file" and $x.name =~ ".(jpe?g|png)"}
  | get name)

  let choice = match $mode {
    "rofi" => {
      ($file_choices | to text | rofi -dmenu -i -P "Select wallpaper")
    },
    "random" => {
      ($file_choices | shuffle | first) 
    },
    _ => { error make {msg: $"($mode) is not a recognized wallpaper mode"} }
  }

  swww img $choice
  echo $"Set wallpaper to ($choice)"
}
