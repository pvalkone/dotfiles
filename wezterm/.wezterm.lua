local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('Input Nerd Font')
config.font_size = 13.0
config.color_scheme = 'Dracula'
config.window_background_opacity = 0.9

return config
