-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly

-- MONITOR2 is a Dell U3225QE
hl.monitor({
	output = PRIMARY_MONITOR,
	mode = PRIMARY_MONITOR_MODE,
	position = "0x0",
	scale = "1.25",
	transform = 0,
})
