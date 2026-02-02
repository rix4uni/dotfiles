-- Pull in the wezterm API
local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_domain = "WSL:Ubuntu"
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = 'Ubuntu',
    username = "root",
    default_cwd = "~",
    default_prog = {"bash"},
  },
}

-- Remove the title bar from the window
config.window_decorations = "TITLE | RESIZE"

config.color_scheme = "Nord (Gogh)"
config.default_cursor_style = "BlinkingBar"
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true
config.enable_tab_bar = true
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.use_fancy_tab_bar = false
config.tab_max_width = 25
config.tab_bar_at_bottom = false
config.pane_focus_follows_mouse = true
config.scrollback_lines = 5000

-- Don't hide cursor when typing
config.hide_mouse_cursor_when_typing = false

-- Remove all padding
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.line_height = 0.9

-- Font configuration
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 12.5

-- === Background Layers ===
-- 1. Image layer (wallpaper)
local wallpaper_layer = {
  source = {
    File = "D:\\wallpaper\\yourname.jpg",
  },
  hsb = {
    hue = 1.0,
    saturation = 1.02,
    brightness = 0.25,
  },
  width = "100%",   -- scale image to fill width
  height = "100%",  -- scale image to fill height
}

-- 2. Color overlay layer (for tint/dim)
local color_overlay = {
  source = {
    Color = "#282c35",  -- dark semi-transparent layer
  },
  width = "100%",
  height = "100%",
  opacity = 0.55,   -- semi-transparent (0.0 to 1.0)
}

-- Combine layers
config.background = {
  wallpaper_layer,
  color_overlay,
}

-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = '\\((\\w+://\\S+)\\)',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = '\\[(\\w+://\\S+)\\]',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = '\\{(\\w+://\\S+)\\}',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = '<(\\w+://\\S+)>',
    format = '$1',
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    -- Before
    --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    --format = '$0',
    -- After
    regex = '[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)',
    format = '$1',
    highlight = 1,
  },
  -- implicit mailto link
  {
    regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
    format = 'mailto:$0',
  },
}

-- Hot-Key Configuration
config.keys = {
  -- Maximize fullscreen
  {key = 'F11', action = wezterm.action.ToggleFullScreen},
}

-- Return the configuration to wezterm
return config
