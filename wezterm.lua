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
	brights = { "#5c6370", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
  -- 标签页
  tab_bar = {
    background = 'rgba(0,0,0,0)', -- 透明背景
    active_tab = {
      bg_color = '#61afef',
      fg_color = '#282c34',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = 'rgba(0,0,0,0)', -- 未激活标签背景透明
      fg_color = '#5c6370',       -- 未激活文字调暗
    },
    inactive_tab_edge = 'rgba(0,0,0,0)',
  },
}

return {
	-- 字体设置（推荐使用 Nerd Font 以支持图标）
	font = wezterm.font_with_fallback({
		"Liga SFMono Nerd Font",
	}),
	font_size = 18,
  line_height = 1.2,
  -- 连字设置
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  -- 主题配色
	colors = onedark,

	-- 启用多标签和分屏
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,

	-- 快捷键：使用 Cmd（macOS）
	keys = mykeys,

	selection_word_boundary = "{}[]()\"/'`.,;: -<>",

	-- 启用真彩色和 emoji 支持
	enable_wayland = false, -- macOS 不需要
	enable_kitty_graphics = true,

  -- UI 设置
	initial_rows = 60,
	initial_cols = 200,
  window_padding = {
    left = '1cell',
    right = '1cell',
    top = '10pt',
    bottom = '10pt',
  },
  window_background_opacity = 0.9,
  macos_window_background_blur = 30,
  window_decorations = "RESIZE",
  win32_system_backdrop = "Acrylic",

  -- Tab 设置
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  tab_max_width = 32,
  show_new_tab_button_in_tab_bar = false,

  -- 光标
  animation_fps = 60,
  default_cursor_style = 'BlinkingBar',
  cursor_blink_rate = 700,
  cursor_blink_ease_in = 'EaseIn',
  cursor_blink_ease_out = 'EaseOut',

}
