-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/monitor.lua
--  Three-state monitor management using eww integer indices.
--
--  eww does NOT understand Hyprland output names ("eDP-1", "HDMI-A-1").
--  It uses its own integer index list. We let Hyprland control which
--  physical display is index 0 by enabling/disabling outputs, and always
--  open `bar` on index 0.
--
--  ┌──────────────┬──────────────┬──────────────┬────────────────────────┐
--  │ State        │ Index 0      │ Index 1      │ eww windows            │
--  ├──────────────┼──────────────┼──────────────┼────────────────────────┤
--  │ Laptop only  │ eDP-1        │ —            │ bar                    │
--  │ Dual         │ eDP-1        │ external     │ bar + bar-ext          │
--  │ Clamshell    │ external     │ —            │ bar (reopened on ext)  │
--  └──────────────┴──────────────┴──────────────┴────────────────────────┘
--
--  hyprlock: monitor = (blank) in hyprlock.conf → renders on ALL active
--  monitors automatically — no extra config needed here.
-- ════════════════════════════════════════════════════════════════════════════

-- ── Known external outputs ────────────────────────────────────────────────
local EXT = {
	["HDMI-A-1"] = { mode = "highres@highrr", position = "auto-right", scale = 1.5 },
	["DP-1"] = { mode = "highres@highrr", position = "auto-right", scale = 1.5 },
}

-- ── Static: built-in display ──────────────────────────────────────────────
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1,
	transform = 0,
})

-- ── State ─────────────────────────────────────────────────────────────────
local connected_ext = nil -- external monitor name, or nil
local lid_closed = false

-- ── Helpers ───────────────────────────────────────────────────────────────

local function eww(cmd)
	hl.exec_cmd("eww " .. cmd .. " 2>/dev/null")
end

-- Wallpaper: copy whatever is loaded on eDP-1 to the new monitor
local function set_wallpaper(name)
	hl.exec_cmd('hyprctl hyprpaper wallpaper "' .. name .. ',$(hyprctl hyprpaper listloaded | head -1)"')
end

-- ── DOCK: external monitor connected ─────────────────────────────────────
hl.on("monitor.added", function(monitor)
	local cfg = EXT[monitor.name]
	if not cfg then
		return
	end

	connected_ext = monitor.name

	-- Configure alongside laptop display (both active)
	hl.exec_cmd(
		"hyprctl keyword monitor '" .. monitor.name .. "," .. cfg.mode .. "," .. cfg.position .. "," .. cfg.scale .. "'"
	)

	set_wallpaper(monitor.name)

	-- Open bar-ext on index 1 (external is second monitor)
	-- Delay so the monitor layer is ready before eww attaches
	hl.exec_cmd("sleep 0.5 && eww open bar-ext")
end)

-- ── UNDOCK: external monitor removed ─────────────────────────────────────
hl.on("monitor.removed", function(monitor)
	if not EXT[monitor.name] then
		return
	end

	connected_ext = nil

	-- Close the external bar
	eww("close bar-ext")

	-- If we were in clamshell, re-enable laptop screen and reopen bar on it
	if lid_closed then
		hl.exec_cmd("hyprctl keyword monitor 'eDP-1,highres@highrr,auto,1,transform,0'")
		hl.exec_cmd("sleep 0.3 && eww open bar")
	end
end)

-- ── CLAMSHELL: lid closed ─────────────────────────────────────────────────
hl.bind("switch:on:lid-switch", function()
	lid_closed = true

	if connected_ext then
		-- Close bar-ext (index 1 is about to disappear as eDP-1 becomes 0-only ext)
		eww("close bar-ext")

		-- Disable laptop screen → external becomes index 0
		hl.exec_cmd("hyprctl keyword monitor 'eDP-1,disable'")

		-- Reopen bar — now lands on external (index 0)
		hl.exec_cmd("sleep 0.3 && eww open bar")
	end
	-- If no external is connected, do nothing (closing lid with no ext = suspend via hypridle)
end, { locked = true, description = "Lid closed: clamshell mode" })

-- ── LID OPEN: restore laptop display ─────────────────────────────────────
hl.bind("switch:off:lid-switch", function()
	lid_closed = false

	-- Re-enable laptop screen → eDP-1 becomes index 0 again
	hl.exec_cmd("hyprctl keyword monitor 'eDP-1,highres@highrr,auto,1,transform,0'")

	-- Brief delay so eDP-1 is fully up before eww/bar-ext open
	if connected_ext then
		-- Dual mode: bar stays on 0 (eDP-1), reopen bar-ext on 1 (external)
		hl.exec_cmd("sleep 0.3 && eww open bar-ext")
	end
	-- bar is still open on index 0; after eDP-1 re-enables it shifts back to laptop
end, { locked = true, description = "Lid opened: restore built-in display" })
