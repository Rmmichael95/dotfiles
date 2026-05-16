-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/input.lua
--  Keyboard, touchpad, per-device overrides, gesture, cursor.
--  See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- ════════════════════════════════════════════════════════════════════════════

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape", -- Caps → Escape (vim muscle memory)
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
			disable_while_typing = true,
			tap_to_click = true,
			drag_lock = false,
			scroll_factor = 1.0,
			clickfinger_behavior = false,
		},
	},

	cursor = {
		no_hardware_cursors = true,
	},
})

-- 3-finger horizontal swipe → workspace switch
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- ── Per-device overrides ──────────────────────────────────────────────────
hl.device({
	name = "dell0d70:00-04f3:3331-touchpad",
	sensitivity = 0,
	scroll_factor = 1.0,
	disable_while_typing = true,
	natural_scroll = false,
	tap_to_click = true,
	drag_lock = false,
})

hl.device({
	name = "dell0d70:00-04f3:3331-mouse",
	sensitivity = 0,
	scroll_factor = 1.0,
})
