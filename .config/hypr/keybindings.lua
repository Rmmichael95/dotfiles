-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/keybindings.lua
--  Ryan M Sullivan · Vim-driven Hyprland keybindings (Lua 0.55+)
--
--  Loaded from hyprland.lua via:  require("keybindings")
--
--  Navigation model (consistent hjkl at every scope):
--    Ctrl+hjkl     → nvim splits ↔ tmux panes  (vim-tmux-navigator)
--    Super+hjkl    → Hyprland compositor window focus
--    Super+Shift   → Hyprland window swap
--    Super+Alt     → Hyprland window resize
--    Alt+hjkl      → Ghostty pane navigation
--
--  Bind option fields (third arg table):
--    description  = "..."          — shown in hyprctl binds (replaces bindd)
--    repeating    = true           — fire continuously while held  (was 'e')
--    locked       = true           — fires even on lock screen     (was 'l')
--    mouse        = true           — mouse button bind             (was 'm')
-- ════════════════════════════════════════════════════════════════════════════

local mainMod = "SUPER"

-- All shared vars (terminal, menu, nmenu, pmenu, osd, shotDir, shotFile)
-- are globals declared in globals.lua — no re-declaration needed here.

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- APPS & LAUNCHERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- terminal / fileManager / menu / nmenu are globals set in hyprland.lua
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("uwsm app -- " .. terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu), { description = "App launcher (bemenu)" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(nmenu), { description = "Nvidia GPU menu" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "File manager (yazi)" })

-- Note / todo quick capture
hl.bind(
	mainMod .. " + CTRL + N",
	hl.dsp.exec_cmd([[uwsn app -- sh -c 'ghostty --command="nvim ~/documents/.bc/batcave/Notes/$(bemenu-input).md"']]),
	{ description = "New note (nvim)" }
)
hl.bind(
	mainMod .. " + CTRL + T",
	hl.dsp.exec_cmd(
		[[uwsn app -- sh -c 'ghostty --command="nvim ~/documents/.bc/batcave/TODO/$(bemenu-input)-todo.md"']]
	),
	{ description = "New todo (nvim)" }
)

-- Markdown notification scripts
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("MarkdownToColorNotifyAll.sh"), { description = "Markdown notify all" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("MarkdownToColorNotify.sh"), { description = "Markdown notify" })

-- Keybind viewer
hl.bind(
	mainMod .. " + SLASH",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/myBin/menu/bemenu-keybinds"),
	{ description = "Show keybindings" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WINDOW MANAGEMENT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + X", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.close(), { description = "Kill active window (alt)" })
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(), { description = "Fullscreen" })
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }), { description = "Maximize / monocle" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"), { description = "Toggle notification center" })

-- ── Window cycling
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { description = "Cycle to next window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ prev = true }), { description = "Cycle to prev window" })

-- Focus-or-launch browser (idempotent: focus existing or spawn new)
-- hl.bind(mainMod .. " + SHIFT + B",
--     hl.dsp.exec_cmd("hyprctl dispatch focuswindow class:floorp || uwsm app -- floorp"),
--     { description = "Browser (focus or launch)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- STATUS BAR (eww)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(
	mainMod .. " + SHIFT + SPACE",
	hl.dsp.exec_cmd("eww close bar 2>/dev/null || eww open bar"),
	{ description = "Toggle eww bar" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LAYOUT & TILING (dwindle)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Pseudo tile" })
hl.bind(mainMod .. " + CTRL + S", hl.dsp.layout("togglesplit"), { description = "Toggle split direction" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FOCUS NAVIGATION
--
-- Layers (non-overlapping scopes):
--   Ctrl+hjkl  → nvim splits ↔ tmux panes via vim-tmux-navigator
--   Super+hjkl → Hyprland compositor window focus  (this section)
--   Arrow keys → Hyprland fallback
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })

-- Arrow key fallback (coexists with hjkl, no conflict)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Move focus left (arrow)" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right (arrow)" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Move focus up (arrow)" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Move focus down (arrow)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WINDOW SWAP
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }), { description = "Swap window left" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }), { description = "Swap window down" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }), { description = "Swap window up" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }), { description = "Swap window right" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- RESIZE — Super+Alt+hjkl
-- (hl.dsp.window.resize with relative=true is the keyboard resize dispatcher)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(
	mainMod .. " + ALT + H",
	hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
	{ description = "Resize window left" }
)
hl.bind(
	mainMod .. " + ALT + L",
	hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
	{ description = "Resize window right" }
)
hl.bind(
	mainMod .. " + ALT + K",
	hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
	{ description = "Resize window up" }
)
hl.bind(
	mainMod .. " + ALT + J",
	hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
	{ description = "Resize window down" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WORKSPACES
--
-- Three workspace move behaviors:
--   Super+1-9       → switch to workspace
--   Super+Shift+1-9 → move window to workspace AND follow it
--   Super+Ctrl+1-9  → throw window to workspace silently (stay put)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

for i = 1, 10 do
	local key = tostring(i % 10) -- 10 → "0"

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })

	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)

	hl.bind(
		mainMod .. " + CTRL + " .. key,
		hl.dsp.window.move({ workspace = i, silent = true }),
		{ description = "Throw window to workspace " .. i .. " (silent)" }
	)
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SCRATCHPAD (special workspace)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:magic" }),
	{ description = "Move window to scratchpad" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MOUSE WORKSPACE SCROLL
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace (scroll)" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace (scroll)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MOUSE — move / resize windows by dragging
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window (mouse)" })

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SCREENSHOTS — grim + slurp pipeline
--
-- Mnemonic: P = Picture
--   Super+Ctrl+P       → area select  → clipboard  (primary daily use)
--   Super+Ctrl+Shift+P → area select  → file       (save to ~/pictures/screenshots/)
--   Super+Shift+P      → full screen  → clipboard
--   Print              → full screen  → file
--   Super+Alt+P        → active window → clipboard
--   Super+Shift+G      → OnScreenToClip custom script
--
-- Note: XCURSOR_SIZE=24 prevents slurp cursor from flickering on HiDPI
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- shotDir and shotFile come from globals.lua

hl.bind(
	mainMod .. " + CTRL + P",
	hl.dsp.exec_cmd([[grim -g "$(XCURSOR_SIZE=24 slurp)" - | wl-copy]]),
	{ description = "Screenshot area → clipboard" }
)

hl.bind(
	mainMod .. " + CTRL + SHIFT + P",
	hl.dsp.exec_cmd("mkdir -p " .. shotDir .. ' && grim -g "$(XCURSOR_SIZE=24 slurp)" ' .. shotFile),
	{ description = "Screenshot area → file" }
)

hl.bind(
	mainMod .. " + SHIFT + P",
	hl.dsp.exec_cmd("grim - | wl-copy"),
	{ description = "Screenshot fullscreen → clipboard" }
)

hl.bind(
	"Print",
	hl.dsp.exec_cmd("mkdir -p " .. shotDir .. " && grim " .. shotFile),
	{ description = "Screenshot fullscreen → file" }
)

hl.bind(
	mainMod .. " + ALT + P",
	hl.dsp.exec_cmd(
		[[grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | wl-copy]]
	),
	{ description = "Screenshot active window → clipboard" }
)

hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/myBin/OnScreenToClip"),
	{ description = "Screen clip (OnScreenToClip)" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SYSTEM & HARDWARE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock screen" })
hl.bind(mainMod .. " + CTRL + Escape", hl.dsp.exec_cmd("systemctl suspend"), { description = "Suspend system" })
hl.bind(
	mainMod .. " + SHIFT + Z",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/myBin/menu/bemenu_power 'Poweroff?'"),
	{ description = "Power menu" }
)
-- NOTE: uwsm users must NOT use hl.dsp.exit() — it tears down the session incorrectly
hl.bind(mainMod .. " + CTRL + Z", hl.dsp.exec_cmd("uwsm stop"), { description = "Exit Hyprland" })

-- Battery charge threshold (TLP — laptop only)
hl.bind(
	mainMod .. " + CTRL + C",
	hl.dsp.exec_cmd("doas tlp setcharge BAT0 1"),
	{ description = "Battery charge limit ON" }
)
hl.bind(
	mainMod .. " + SHIFT + C",
	hl.dsp.exec_cmd("doas tlp setcharge BAT0 0"),
	{ description = "Battery charge limit OFF" }
)

-- Keyboard backlight
hl.bind(
	mainMod .. " + CTRL + B",
	hl.dsp.exec_cmd("brightnessctl -d white:kbd_backlight s 50%"),
	{ description = "Keyboard backlight 50%" }
)

-- Power profiles
hl.bind(
	mainMod .. " + SHIFT + F1",
	hl.dsp.exec_cmd("powerprofilesctl set power-saver"),
	{ description = "Power profile: power-saver" }
)
hl.bind(
	mainMod .. " + SHIFT + F2",
	hl.dsp.exec_cmd("powerprofilesctl set balanced"),
	{ description = "Power profile: balanced" }
)
hl.bind(
	mainMod .. " + SHIFT + F3",
	hl.dsp.exec_cmd("powerprofilesctl set performance"),
	{ description = "Power profile: performance" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MEDIA — XF86 hardware keys
--
-- Routes through ~/.local/bin/myBin/media/osd which:
--   1. Calls swayosd-client (shows OSD overlay) if server is running
--   2. Falls back to raw wpctl / brightnessctl if server is down
--
-- { locked = true, repeating = true } — hold-to-repeat + lock-screen-safe
-- { locked = true }                   — fire-once + lock-screen-safe
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- osd comes from globals.lua

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osd .. " vol-up"),
	{ locked = true, repeating = true, description = "Volume up 5%" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osd .. " vol-down"),
	{ locked = true, repeating = true, description = "Volume down 5%" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(osd .. " vol-mute"),
	{ locked = true, repeating = true, description = "Mute audio toggle" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(osd .. " mic-mute"),
	{ locked = true, repeating = true, description = "Mute microphone toggle" }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osd .. " bright-up"),
	{ locked = true, repeating = true, description = "Screen brightness +5%" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osd .. " bright-down"),
	{ locked = true, repeating = true, description = "Screen brightness -5%" }
)
hl.bind(
	"xf86poweroff",
	hl.dsp.exec_cmd(pmenu .. " 'Do you want to poweroff?'"),
	{ locked = true, repeating = true, description = "Power menu (hw button)" }
)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / Pause" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play / Pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })

-- Volume reset (swayOSD has no "set absolute" command, use wpctl directly)
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%"),
	{ description = "Reset volume to 100%" }
)

-- Note / todo quick capture
hl.bind(
	mainMod .. " + CTRL + N",
	hl.dsp.exec_cmd([[uwsn app -- sh -c 'ghostty --command="nvim ~/documents/.bc/batcave/Notes/$(bemenu-input).md"']]),
	{ description = "New note (nvim)" }
)
hl.bind(
	mainMod .. " + CTRL + T",
	hl.dsp.exec_cmd(
		[[uwsn app -- sh -c 'ghostty --command="nvim ~/documents/.bc/batcave/TODO/$(bemenu-input)-todo.md"']]
	),
	{ description = "New todo (nvim)" }
)

-- UPGRADED: NPU Deep Topic Section Search & Jump
hl.bind(
	mainMod .. " + SHIFT + N",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/myBin/npu/npu-hypr-search"),
	{ description = "AI Deep Topic Note Search (bemenu)" }
)
