-- ════════════════════════════════════════════════════════════════════════════
--  ~/.config/hypr/autostart.lua
--  One-shot session daemons — fires once at login, not on config reload.
--  See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
--  Reads globals: (none — all paths are literals or systemd unit names)
-- ════════════════════════════════════════════════════════════════════════════

hl.on("hyprland.start", function()
	-- GPG socket generation
	hl.exec_cmd("uwsm app -- gpgconf --launch gpg-agent")
	hl.exec_cmd("uwsm app -- gpg-connect-agent reloadagent /bye")

	-- Systemd user services
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("systemctl --user start hyprpaper")
	hl.exec_cmd("systemctl --user start hypridle")
	hl.exec_cmd("systemctl --user start swayosd.service")

	-- IIO sensor integration (auto-rotate on tablet mode)
	hl.exec_cmd("uwsm app -- iio-hyprland")

	-- Open laptop bar on startup (external bar opened by monitor.lua on dock)
	hl.exec_cmd("sleep 1 && eww open bar-laptop")
end)
