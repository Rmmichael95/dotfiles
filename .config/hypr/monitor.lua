-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/monitor.lua
--  Monitor layout + hotplug handling.
--
--  Replaces hyprland-monitor-attached + monitor_add.sh / monitor_remove.sh.
--  Uses native Lua events so eww bar, hyprpaper, and lock screen are all
--  handled automatically in one place on dock/undock.
--
--  Assumes single external monitor: HDMI-A-1
--  Add entries to KNOWN_MONITORS for additional outputs.
-- ════════════════════════════════════════════════════════════════════════════

-- ── Static: laptop built-in display ──────────────────────────────────────
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1,
	transform = 0,
})

-- ── Known external monitors ───────────────────────────────────────────────
-- Add an entry here for each external output you use.
local KNOWN_MONITORS = {
	["HDMI-A-1"] = { mode = "highres@highrr", position = "0x0", scale = 2 },
	["DP-1"] = { mode = "highres@highrr", position = "0x0", scale = 2 },
}

-- ── Helpers ───────────────────────────────────────────────────────────────

-- Restart eww bar. The sleep gives Hyprland time to finish reconfiguring
-- the monitor layer before eww tries to attach.
local function restart_eww()
	hl.exec_cmd("eww close bar 2>/dev/null; sleep 0.3 && eww open bar")
end

-- Apply the currently loaded hyprpaper wallpaper to a new monitor so you
-- never get a blank external screen.
local function set_wallpaper(monitor_name)
	hl.exec_cmd('hyprctl hyprpaper wallpaper "' .. monitor_name .. ',$(hyprctl hyprpaper listloaded | head -1)"')
end

-- Move all workspaces (1–10) to the named monitor.
local function move_workspaces_to(monitor_name)
	for i = 1, 10 do
		hl.exec_cmd("hyprctl dispatch moveworkspacetomonitor " .. i .. " " .. monitor_name)
	end
end

-- ── Dock: external monitor connected ─────────────────────────────────────
hl.on("monitor.added", function(monitor)
	local cfg = KNOWN_MONITORS[monitor.name]
	if not cfg then
		return
	end -- ignore unknown outputs

	local name = monitor.name

	-- 1. Configure the external monitor at full resolution/refresh
	hl.exec_cmd(
		"hyprctl keyword monitor '" .. name .. "," .. cfg.mode .. "," .. cfg.position .. "," .. cfg.scale .. "'"
	)

	-- 2. Disable the laptop screen (clamshell / focused desktop mode)
	hl.exec_cmd("hyprctl keyword monitor 'eDP-1,disable'")

	-- 3. Move all workspaces to external monitor
	move_workspaces_to(name)

	-- 4. Set wallpaper on external monitor
	set_wallpaper(name)

	-- 5. Restart eww bar — attaches to monitor 0 (now the external one)
	restart_eww()
end)

-- ── Undock: external monitor removed ─────────────────────────────────────
hl.on("monitor.removed", function(monitor)
	if not KNOWN_MONITORS[monitor.name] then
		return
	end

	-- 1. Re-enable laptop screen at native settings
	hl.exec_cmd("hyprctl keyword monitor 'eDP-1,highres@highrr,auto,1,transform,0'")

	-- 2. Move all workspaces back to laptop screen
	move_workspaces_to("eDP-1")

	-- 3. Restart eww bar on laptop monitor
	restart_eww()
end)
