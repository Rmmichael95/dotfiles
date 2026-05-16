-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/rules.lua
--  Window rules and workspace rules.
--  See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- ════════════════════════════════════════════════════════════════════════════

-- Ignore maximize requests from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix XWayland drag/focus issues
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Slack screen-draw overlay (always-on-top transparent layer)
hl.window_rule({
	name = "slack-draw-overlay",
	match = {
		class = "^(com%.slack%.Slack|Slack)$",
		title = "^(<OVERLAY_TITLE>)$",
	},
	float = true,
	fullscreen = 1,
	pin = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	no_shadow = true,
})

-- XWayland video bridge — hide completely
hl.window_rule({
	name = "hide-xwayland-video-bridge-opacity",
	match = { class = "^(xwaylandvideobridge)$" },
	opacity = "0.0 override",
	no_anim = true,
	no_focus = true,
	no_blur = true,
	no_shadow = true,
})

hl.window_rule({
	name = "hide-xwayland-video-bridge-workspace",
	match = { class = "^(xwaylandvideobridge)$" },
	workspace = "20 silent",
	opacity = "0.0 override",
	no_anim = true,
	no_focus = true,
	no_blur = true,
	no_shadow = true,
})

-- ── Smart gaps (uncomment to enable "no gaps when only one window") ────────
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]"   }, border_size = 0, rounding = 0 })
