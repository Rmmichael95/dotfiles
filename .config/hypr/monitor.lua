-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/monitor.lua
--  Single External Monitor + Clamshell Mode (Dynamic Workspaces)
-- ════════════════════════════════════════════════════════════════════════════

-- Track our single external monitor dynamically (e.g., "DP-1" or "HDMI-A-1")
local ext_name = nil

-- ── Static: built-in display fallback configuration ───────────────────────
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = 1,
})

-- Reads the hardware state file to accurately sync lid posture at boot time
local function check_lid_state()
	local f = io.popen("cat /proc/acpi/button/lid/LID*/state 2>/dev/null")
	if f then
		local status = f:read("*a")
		f:close()
		return status:match("closed") ~= nil
	end
	return false
end

local lid_closed = check_lid_state()

-- ── Centralized Eww Bar Alignment ────────────────────────────────────────
local function arrange_bars()
	-- Close all bars first to ensure a clean state
	hl.exec_cmd("eww close bar bar-ext 2>/dev/null")

	-- Give the compositor a split second to finish shifting window viewports
	hl.exec_cmd("sleep 0.3")

	if lid_closed and ext_name then
		-- Clamshell mode: Only the external monitor is active (Index 0)
		hl.exec_cmd("eww open bar")
	elseif not lid_closed and ext_name then
		-- Extended desktop: Laptop (Index 0) + External (Index 1) are active
		hl.exec_cmd("eww open bar && eww open bar-ext")
	elseif not lid_closed and not ext_name then
		-- Laptop only mode
		hl.exec_cmd("eww open bar")
	end
end

-- ── Dynamic Monitor Connection Triggers ──────────────────────────────────
hl.on("monitor.added", function(monitor)
	if monitor.name == "eDP-1" then
		if lid_closed then
			hl.exec_cmd("hyprctl keyword monitor 'eDP-1,disable'")
		end
		arrange_bars()
		return
	end

	-- A new external monitor was plugged in. Track it and configure it.
	ext_name = monitor.name
	-- You can adjust scale (1.5) or position ('auto') here
	hl.exec_cmd(string.format("hyprctl keyword monitor '%s,highres@highrr,auto,1.5'", ext_name))

	if lid_closed then
		-- Enforce clamshell state if plugged in while the lid is down
		hl.exec_cmd("hyprctl keyword monitor 'eDP-1,disable'")
		hl.exec_cmd("hyprctl dispatch focusmonitor " .. ext_name)
	else
		-- Extended mode: pull focus to the newly connected screen
		hl.exec_cmd("hyprctl dispatch focusmonitor " .. ext_name)
	end

	arrange_bars()
end)

hl.on("monitor.removed", function(monitor)
	if monitor.name == "eDP-1" then
		return
	end

	-- If our tracked external monitor is unplugged, clear the variable
	if monitor.name == ext_name then
		ext_name = nil

		-- Emergency fallback: Re-enable laptop display if completely undocked with lid closed
		if lid_closed then
			hl.exec_cmd("hyprctl keyword monitor 'eDP-1,preferred,0x0,1'")
		end
	end

	arrange_bars()
end)

-- ── ACPI Hardware Switches (Lid Action) ──────────────────────────────────
hl.bind("switch:on:Lid Switch", function()
	lid_closed = true

	-- Only trigger Clamshell mode if an external monitor is actually connected.
	-- If ext_name is nil, we do nothing and let systemd put the laptop to sleep.
	if ext_name then
		hl.exec_cmd("hyprctl keyword monitor 'eDP-1,disable'")
		arrange_bars()
	end
end, { locked = true, description = "Lid closed: Clamshell mode (if docked)" })

hl.bind("switch:off:Lid Switch", function()
	lid_closed = false

	-- Always restore the built-in display when the lid is opened
	hl.exec_cmd("hyprctl keyword monitor 'eDP-1,preferred,0x0,1'")
	arrange_bars()
end, { locked = true, description = "Lid opened: Restore built-in display" })
