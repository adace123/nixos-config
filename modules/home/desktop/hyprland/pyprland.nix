{
  pkgs,
  std,
  ...
}: {
  home.packages = [pkgs.pyprland];
  xdg.configFile.pypr = {
    target = "hypr/pyprland.toml";
    text = std.serde.toTOML {
      pyprland.plugins = ["scratchpads"];
      scratchpads = {
        terminal = {
          command = "alacritty --class scratchpad";
          # animation = "fromTop";
          lazy = true;
          size = "60% 60%";
        };
      };
    };
  };
}
