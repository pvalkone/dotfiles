local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.font = wezterm.font('Input Nerd Font')
config.font_size = 13.0
config.color_scheme = 'Dracula'
config.window_background_opacity = 0.9

return config
