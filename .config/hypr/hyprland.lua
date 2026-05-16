-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/hyprland.lua
--  Ryan M Sullivan · Hyprland 0.55+ entry point
--
--  This file is intentionally thin. Each require() runs in its own Lua
--  scope, so an error in one module does not abort the others.
--
--  Load order matters:
--    1. globals   — shared variables (terminal, menu, paths…)
--    2. monitor   — output layout
--    3. autostart — one-shot session daemons
--    4. theme     — look & feel, animations, layout engines
--    5. input     — keyboard, touchpad, devices, gesture
--    6. rules     — window & workspace rules
--    7. keybindings
--
--  LSP stubs: /usr/share/hypr/stubs/
--  Wiki:      https://wiki.hypr.land/Configuring/Start/
-- ════════════════════════════════════════════════════════════════════════════

require("globals") -- must be first: declares all shared globals
require("monitor")
require("autostart")
require("theme")
require("input")
require("rules")
require("keybindings")
