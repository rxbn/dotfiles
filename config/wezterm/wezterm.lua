local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 0,
}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 15

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"

config.warn_about_missing_glyphs = false

return config
