local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
  default_domain = "WSL:Ubuntu-24.04",

  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  color_scheme = "Nord (Gogh)",
  font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
  font_size = 12.5,
  background = {
    {
      source = {
        File = "C:\\Users\\rix4uni\\Downloads\\wallpaper\\yourname.jpg",
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
      width = "100%",
      height = "100%",
    },
    {
      source = {
        Color = "#282c35",
      },
      width = "100%",
      height = "100%",
      opacity = 0.55,
    },
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

return config