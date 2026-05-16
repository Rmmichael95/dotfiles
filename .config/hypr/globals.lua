-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/globals.lua
--  Single source of truth for all shared variables.
--
--  Variables declared WITHOUT `local` are Lua globals — they are visible
--  to every subsequent require()d file with no re-declaration needed.
--
--  Required first by hyprland.lua before any other module.
-- ════════════════════════════════════════════════════════════════════════════

-- ── Paths ─────────────────────────────────────────────────────────────────
local home = os.getenv("HOME")
local bin = home .. "/.local/bin/myBin"

-- ── Programs ──────────────────────────────────────────────────────────────
terminal = os.getenv("TERMINAL") or "ghostty"
fileManager = terminal .. " -e yazi"

-- ── Menus ─────────────────────────────────────────────────────────────────
menu = bin .. "/menu/bemenu-uwsm"
nmenu = bin .. "/menu/nvidia-menu"
pmenu = bin .. "/menu/bemenu-power"

-- ── Media / OSD ───────────────────────────────────────────────────────────
osd = bin .. "/media/osd"

-- ── Screenshots ───────────────────────────────────────────────────────────
shotDir = home .. "/pictures/screenshots"
-- shotFile uses shell date evaluated at press-time, not config-load-time
shotFile = shotDir .. "/$(date +%Y-%m-%d_%H-%M-%S).png"
