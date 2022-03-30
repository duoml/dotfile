local wezterm = require 'wezterm';

local schemes = {}
local schemeIdx = 31
for name, scheme in pairs(wezterm.get_builtin_color_schemes()) do
    table.insert(schemes, name)
end
table.sort(schemes)

local function showScheme(window)
    wezterm.log_error("current color scheme is ", schemeIdx, window:effective_config().color_scheme)
end

local function prevScheme(window)
    schemeIdx = (schemeIdx - 1 + #schemes) % #schemes
    -- Pick a random scheme name
    local scheme = schemes[schemeIdx]
    window:set_config_overrides({
        color_scheme = scheme
    })
    showScheme(window)
end

local function nextScheme(window)
    schemeIdx = (schemeIdx + 1 + #schemes) % #schemes
    -- Pick a random scheme name
    local scheme = schemes[schemeIdx]
    window:set_config_overrides({
        color_scheme = scheme
    })
    showScheme(window)
end

local mykeys = {}
for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(mykeys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action {
            ActivateTab = i - 1
        }
    })
end

table.insert(mykeys, {
    key = "w",
    mods = "CTRL",
    action = wezterm.action {
        CloseCurrentTab = {
            confirm = true
        }
    }
})
table.insert(mykeys, {
    key = "w",
    mods = "SHIFT|CTRL",
    action = wezterm.action {
        CloseCurrentPane = {
            confirm = true
        }
    }
})

table.insert(mykeys, {
    key = "F1",
    action = wezterm.action_callback(prevScheme)
})
table.insert(mykeys, {
    key = "F2",
    action = wezterm.action_callback(nextScheme)
})

local onedark = {
    foreground = "#abb2bf",
    background = "#282c34",
    -- cursor_bg = "#a3b3cc",
    -- cursor_border = "#a3b3cc",
    -- cursor_fg = "#abb2bf",
    selection_bg = "#474e5d",
    selection_fg = "#abb2bf",
    scrollbar_thumb = "#282c34",

    ansi = {"#282c34","#e06c75","#98c379","#e5c07b","#61afef","#c678dd","#56b6c2","#abb2bf"},
    brights = {"#282c34","#e06c75","#98c379","#e5c07b","#61afef","#c678dd","#56b6c2","#abb2bf"},
}

return {
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    keys = mykeys,
    default_prog = {"ssh","duoml@192.168.232.136"},
    -- color_scheme = schemes[schemeIdx],
    colors = onedark,
    selection_word_boundary = "{}[]()\"'`.,;: -<>",
    launch_menu = {{
        label = "PowerShell",
        args = {"powershell"}
    }, {
        label = "SSH-192.168.232.136",
        args = {"ssh", "duoml@192.168.232.136"}
    }},
    mouse_bindings = {{
        event = {
            Up = {
                streak = 1,
                button = "Right"
            }
        },
        mods = "NONE",
        action = "Paste"
    },
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = {
            Up = {
                streak = 1,
                button = "Left"
            }
        },
        mods = "NONE",
        action = wezterm.action {
            CompleteSelection = "PrimarySelection"
        }
    },
    -- and make CTRL-Click open hyperlinks
    {
        event = {
            Up = {
                streak = 1,
                button = "Left"
            }
        },
        mods = "CTRL",
        action = "OpenLinkAtMouseCursor"
    }}

}
