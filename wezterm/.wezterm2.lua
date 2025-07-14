-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_domain = "WSL:Ubuntu-24.04"
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu-24.04',
    distribution = 'Ubuntu-24.04',
    username = "root",
    default_cwd = "~",
    default_prog = {"bash"},
  },
}

-- Remove the title bar from the window
config.window_decorations = "RESIZE"

config.color_scheme = "Nord (Gogh)"
config.default_cursor_style = "BlinkingBar"
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
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

-- Default Window Size
config.initial_cols = 120
config.initial_rows = 30

-- === Background Layers ===
-- 1. Image layer (wallpaper)
local wallpaper_layer = {
  source = {
    File = "C:\\Users\\rix4uni\\Downloads\\wallpaper\\yourname.jpg",
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

-- Set a leader key (e.g., Ctrl+Space)
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Hot-Key Configuration
config.keys = {
  -- Maximize fullscreen
  {key = 'F11', action = wezterm.action.ToggleFullScreen},
  {key = 'm', mods = 'CTRL|LEADER', action = wezterm.action.TogglePaneZoomState},

  -- Create a tab
  {key = 't', mods = 'CTRL|LEADER', action = act.SpawnTab 'CurrentPaneDomain'},

  -- Move between tabs using <Leader>n for the next tab, <Leader>p for the previous
  {key = 'n', mods = 'CTRL|LEADER', action = wezterm.action.ActivateTabRelative(1)},
  {key = 'p', mods = 'CTRL|LEADER', action = wezterm.action.ActivateTabRelative(-1)},

  -- Displaying each tab with their index
  {key = 'w', mods = 'CTRL|LEADER', action = act.ShowTabNavigator},

  -- Kill/Close a tab without needing to type "exit", if a process is stuck
  {key = 'q', mods = 'CTRL|LEADER', action = act.CloseCurrentTab{ confirm = true }},

  -- Show list of workspaces
  {key = 's', mods = 'CTRL|LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' }},

  -- Horizontal split
  {key = '\\', mods = 'CTRL|LEADER', action = wezterm.action.SplitPane {direction = 'Down', size = { Percent = 50 }}},

  -- Vertical split
  {key = '-', mods = 'CTRL|LEADER', action = wezterm.action.SplitPane {direction = 'Right', size = { Percent = 50 }}},

  -- Move between panes using CTRL + h/j/k/l
  { key = 'h', mods = 'CTRL', action = act.EmitEvent("move-left") },
  { key = 'j', mods = 'CTRL', action = act.EmitEvent("move-down") },
  { key = 'k', mods = 'CTRL', action = act.EmitEvent("move-up") },
  { key = 'l', mods = 'CTRL', action = act.EmitEvent("move-right") },

  -- Resize panes using ALT + h/j/k/l
  { key = 'h', mods = 'ALT', action = act.EmitEvent("resize-left") },
  { key = 'j', mods = 'ALT', action = act.EmitEvent("resize-down") },
  { key = 'k', mods = 'ALT', action = act.EmitEvent("resize-up") },
  { key = 'l', mods = 'ALT', action = act.EmitEvent("resize-right") },
}

-- --------------------------------------------------------------------
-- FUNCTIONS AND EVENT BINDINGS
-- --------------------------------------------------------------------

-- Event handlers to make pane navigation work
wezterm.on("move-left", function(window, pane)
  window:perform_action(act.ActivatePaneDirection("Left"), pane)
end)
wezterm.on("move-down", function(window, pane)
  window:perform_action(act.ActivatePaneDirection("Down"), pane)
end)
wezterm.on("move-up", function(window, pane)
  window:perform_action(act.ActivatePaneDirection("Up"), pane)
end)
wezterm.on("move-right", function(window, pane)
  window:perform_action(act.ActivatePaneDirection("Right"), pane)
end)

-- Event handlers to make pane resize work
wezterm.on("resize-left", function(window, pane)
  window:perform_action(act.AdjustPaneSize { "Left", 3 }, pane)
end)

wezterm.on("resize-down", function(window, pane)
  window:perform_action(act.AdjustPaneSize { "Down", 3 }, pane)
end)

wezterm.on("resize-up", function(window, pane)
  window:perform_action(act.AdjustPaneSize { "Up", 3 }, pane)
end)

wezterm.on("resize-right", function(window, pane)
  window:perform_action(act.AdjustPaneSize { "Right", 3 }, pane)
end)

-- Drag window using mouse
config.mouse_bindings = {
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CTRL|SHIFT',
    action = wezterm.action.StartWindowDrag,
  },
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    action = wezterm.action.StartWindowDrag,
  },
}

-- Return the configuration to wezterm
return config