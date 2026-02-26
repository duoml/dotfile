local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- [系统检测] ----------------------------------------------------------------
local function get_os()
	if wezterm.target_triple:find("apple") then
		return "macos"
	end
	if wezterm.target_triple:find("windows") then
		return "windows"
	end
	return "linux"
end
local host_os = get_os()

-- [字体与样式] --------------------------------------------------------------
config.font = wezterm.font_with_fallback({
	{ family = "Liga SFMono Nerd Font", weight = "Regular" },
	"Apple Color Emoji", -- macOS 优先使用原生 Emoji
})
config.font_size = host_os == "macos" and 18 or 14 -- Mac 屏幕密度高，16-18 较舒适
config.line_height = 1.2
-- 关闭连字
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- [颜色主题：OneDark] -------------------------------------------------------
config.colors = {
	foreground = "#abb2bf",
	background = "#282c34",
	cursor_bg = "#61afef",
	cursor_fg = "#282c34",
	selection_bg = "#474e5d",
	selection_fg = "#abb2bf",
	ansi = { "#282c34", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
	brights = { "#5c6370", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
}

-- [快捷键] ------------------------------------------------------------------
local mykeys = {
	-- 跳词移动
	{
		key = "LeftArrow",
		mods = host_os == "macos" and "OPT" or "CTRL",
		action = wezterm.action({ SendString = "\x1bb" }),
	},
	{
		key = "RightArrow",
		mods = host_os == "macos" and "OPT" or "CTRL",
		action = wezterm.action({ SendString = "\x1bf" }),
	},
	-- 删除整词
	{
		key = "Backspace",
		mods = host_os == "macos" and "OPT" or "CTRL",
		action = wezterm.action({ SendString = "\x17" }),
	},
}

-- 快速切换 Tab (Alt + 1-8)
for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end
config.keys = mykeys

-- [窗口与 UI] ---------------------------------------------------------------
config.initial_rows = 60
config.initial_cols = 200
config.window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = "0cell" }

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
config.win32_system_backdrop = "Acrylic"

if host_os == "macos" then
	-- 隐藏标题栏但保留红绿灯，显得极其简洁
	config.window_decorations = "RESIZE"
	-- 允许 Option 键作为输入特殊字符或作为 Meta 键
	config.send_composed_key_when_left_alt_is_pressed = false
	config.send_composed_key_when_right_alt_is_pressed = false
end

-- [标签栏设置] --------------------------------------------------------------
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.colors.tab_bar = {
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
}


-- [性能与高级] --------------------------------------------------------------
config.front_end = "WebGpu" -- macOS/Windows 现代显卡首选
config.animation_fps = 60
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 600
config.selection_word_boundary = "{}[]()\"/'`.,;: -<>"

return config
