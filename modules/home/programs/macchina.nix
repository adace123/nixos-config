{
  pkgs,
  std,
  ...
}: {
  home.packages = [pkgs.macchina];
  xdg.configFile."macchina/macchina.toml".text = std.serde.toTOML {
    show = [
      "Host"
      "Machine"
      "Kernel"
      "Distribution"
      "DesktopEnvironment"
      "LocalIP"
      "Uptime"
      "Processor"
      "ProcessorLoad"
      "Memory"
    ];
  };

  xdg.configFile."macchina/themes/Catppuccin.toml".text = ''
    # Catppuccin

    spacing         = 1
    padding         = 1
    separator       = " "
    key_color       = "#89dceb"
    separator_color = "#89dceb"


    [palette]
    type            = "Light"
    glyph           = " 🐱 "
    visible         = false

    [bar]
    glyph           = "●"
    symbol_open     = '('
    symbol_close    = ')'
    visible         = false
    hide_delimiters = true

    [custom_ascii]
    color           = "Blue"
    path = "~/.config/art/catppuccin"

    [randomize]
    key_color       = false
    separator_color = false
    pool            = "hexadecimal"

    [keys]
    host            = "Host"
    kernel          = "Kernel"
    battery         = "Battery"
    os              = "OS"
    de              = "DE"
    wm              = "WM"
    distro          = "Distro"
    terminal        = "Terminal"
    shell           = "Shell"
    packages        = "Packages"
    uptime          = "Uptime"
    memory          = "Memory"
    machine         = "Machine"
    local_ip        = "IP"
    backlight       = "Brightness"
    resolution      = "Resolution"
    cpu_load        = "CPU Load"
    cpu             = "CPU"
  '';
}
