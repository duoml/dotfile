local wezterm = require("wezterm")

local mykeys = {

}
for i = 1, 8 do
	-- ALT + number to activate that tab
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action({
			ActivateTab = i - 1,
		}),
	})
end

local onedark = {
	foreground = "#abb2bf",
	background = "#282c34",
	-- cursor_bg = "#a3b3cc",
	-- cursor_border = "#a3b3cc",
	-- cursor_fg = "#abb2bf",
	selection_bg = "#474e5d",
	selection_fg = "#abb2bf",
	scrollbar_thumb = "#282c34",

	ansi = { "#282c34", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
	brights = { "#282c34", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
}

return {
	initial_rows = 60,
	initial_cols = 200,
	-- 字体设置（推荐使用 Nerd Font 以支持图标）
	font = wezterm.font_with_fallback({
		"Liga SFMono Nerd Font",
	}),
	font_size = 18,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	colors = onedark,

	-- 启用多标签和分屏
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,

	-- 快捷键：使用 Cmd（macOS）
	keys = mykeys,

	selection_word_boundary = "{}[]()\"/'`.,;: -<>",

	-- 启用真彩色和 emoji 支持
	enable_wayland = false, -- macOS 不需要
	enable_kitty_graphics = true,
}
