-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.term = "xterm-256color"
-- config.set_environment_variables = {
-- 	COLORTERM = "truecolor",
-- }
config.term = "xterm-256color"
config.set_environment_variables = {
	COLORTERM = "truecolor",
}

-- Fonts
config.font_size = 13
config.font = wezterm.font("Monaco")

-- Colors
config.color_scheme = "Catppuccin Mocha"

-- Key maps
local act = wezterm.action

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "m",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
}

return config
