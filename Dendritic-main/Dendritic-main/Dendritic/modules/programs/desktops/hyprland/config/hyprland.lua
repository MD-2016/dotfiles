-- =========================================================================
-- HYPRLAND LUA CONFIGURATION (0.55+)
-- Designed for maximum eye-candy, fluidity, and ergonomics.
-- =========================================================================

-- Monitors: keyed table (output / mode / position / scale)
hl.monitor({ output = "DP-1", mode = "1920x1080@160", position = "0x0", scale = 1 })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 }) -- Fallback for laptops/other setups

-- Environment variables for styling and scaling
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")

-- Auto-start essential daemons & rice components.
-- Wrapped in hyprland.start so they run once per session, not on every reload.
hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon")                -- Wallpaper engine daemon
    hl.exec_cmd("waybar")                   -- Status bar
    hl.exec_cmd("mako")                     -- Notification daemon
    hl.exec_cmd("nm-applet --indicator")    -- Network tray
    hl.exec_cmd("hyprpaper")
    h1.exec_cmd("noctalia")
end)

local mod = "SUPER"

-- =========================================================================
-- INPUT & GESTURES
-- =========================================================================
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- =========================================================================
-- GENERAL & VISUAL STYLING (The "Flashy" Part)
-- =========================================================================
hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        col = {
            -- Neon purple to cyan gradient border
            active_border = { colors = { "rgba(cba6f7ee)", "rgba(89dcebee)" }, angle = 45 },
            inactive_border = "rgba(313244aa)",
        },
        layout = "dwindle",
        resize_on_border = true,
    },
})

hl.config({
    decoration = {
        rounding = 12,
        active_opacity = 1.0,
        inactive_opacity = 0.90,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = true,
            vibrancy = 0.1696,
        },

        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = "rgba(11111b66)",
        },
    },
})

-- =========================================================================
-- BUTTERY SMOOTH ANIMATIONS
-- =========================================================================
-- 1. Register custom Bezier curves first: points are {x0,y0},{x1,y1} pairs
hl.curve("wind",   { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("winIn",  { type = "bezier", points = { { 0.1, 1.1 },  { 0.2, 1.0 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner",  { type = "bezier", points = { { 1, 1 },      { 1, 1 } } })

-- 2. Define animations (bezier = <curve name>)
hl.animation({ leaf = "windows",    enabled = true, speed = 6, bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5, bezier = "winIn",  style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "popin 60%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7, bezier = "wind" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind",   style = "slide" })

-- =========================================================================
-- LAYOUTS
-- =========================================================================
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- =========================================================================
-- KEYBINDINGS
-- =========================================================================
local terminal = "kitty"
local menu = "rofi -show drun"
local command = "hyprctl reload"
local wallpaper = "~/.config/hypr/rofi-wallpaper.sh"

-- Applications & Core Shortcuts
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("firefox"))      -- Super + E opens Firefox
hl.bind(mod .. " + space", hl.dsp.exec_cmd(menu))       -- Super + Space opens Rofi
hl.bind(mod .. " + W", hl.dsp.exec_cmd(wallpaper)) -- Super + W changes wallpaper
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + C", hl.dsp.exec_cmd(command))
-- Was SUPER+J, which collided with "focus down". Moved to SUPER+CTRL+J.
hl.bind(mod .. " + CTRL + J", hl.dsp.layout("togglesplit"))

-- System Actions
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("systemctl suspend")) -- Super + Shift + S suspends system
hl.bind("Print", hl.dsp.exec_cmd("grimblast copysave area ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png")) -- Print Screen takes regional screenshot

-- Focus movement (Vim keys)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Workspaces switching
for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Mouse bindings for moving/resizing windows smoothly
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys (Volume & Brightness): work on lockscreen and repeat when held
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- =========================================================================
-- WINDOW RULES (Opacity, Float modals, etc.)
-- =========================================================================
hl.window_rule({
    match = { class = "^(pavucontrol|org.gnome.Nautilus)$" },
    float = true,
})

hl.window_rule({
    match = { class = "^(kitty)$" },
    opacity = "0.95",
    no_blur = true,
})

hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize",
})
