-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.xcursor_theme = "Adwaita"

wezterm.on("toggle-ligature", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    -- If we haven't overridden it yet, then override with ligatures disabled
    overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  else
    -- else we did already, and we should disable out override now
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "catppuccin-mocha"

config.font_size = 16.0
config.initial_rows = 24
config.initial_cols = 100
-- config.colors = {
--   ansi = {
--      "#000000",
--      "#ff5360",
--      "#59d499",
--      "#ffc531",
--      "#56c2ff",
--      "#cf2f98",
--      "#52eee5",
--      "#ffffff"
--    },
--    background = "#1a1a1a",
--    brights = {
--      --"#555753",
--      "#666764",
--      "#ff6363",
--      "#59d499",
--      "#ffc531",
--      "#56c2ff",
--      "#cf2f98",
--      "#52eee5",
--      "#ffffff"
--    },
--    cursor_bg = "#cccccc",
--    cursor_border = "#cccccc",
--    cursor_fg = "#ffffff",
--    foreground = "#ffffff",
--    indexed = {},
--    selection_bg = "#333333",
--    selection_fg = "#000000"
--  }

config.audible_bell = "Disabled"

-- config.window_frame = {
--   active_titlebar_bg = "#f7f7f7",
--   inactive_titlebar_bg = "#ececec"
-- }

config.keys = {
  { key = "1", mods = "ALT",        action = act.ActivateTab(0) },
  { key = "2", mods = "ALT",        action = act.ActivateTab(1) },
  { key = "3", mods = "ALT",        action = act.ActivateTab(2) },
  { key = "4", mods = "ALT",        action = act.ActivateTab(3) },
  { key = "5", mods = "ALT",        action = act.ActivateTab(4) },
  { key = "6", mods = "ALT",        action = act.ActivateTab(5) },
  { key = "7", mods = "ALT",        action = act.ActivateTab(6) },
  { key = "8", mods = "ALT",        action = act.ActivateTab(7) },
  { key = "9", mods = "ALT",        action = act.ActivateTab(8) },
  { key = "h", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
  { key = "E", mods = "SHIFT|CTRL", action = act.EmitEvent("toggle-ligature") },
}

return config
