-- Input configuration

hl.config({
	input = {
		accel_profile = "flat",
		kb_layout = "gmc",
		kb_model = "pc105", -- i.e., iso
		kb_variant = "zsa",
		resolve_binds_by_sym = 1, -- ensures SUPER works on all layouts
	},
})

-- Keyboards ─────────────────────────────────────────────────────────────────
-- All keyboards but the laptop keyboard are QWERTY (see input for default)

hl.device({
	name = "at-translated-set-2-keyboard",
	kb_layout = "gmc",
	kb_variant = "colemak-dh",
	kb_model = "pc105", -- i.e., iso
})

-- Gestures ──────────────────────────────────────────────────────────────────

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", mods = "SUPER", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })

-- Onscreen keyboard
-- hl.gesture({
--  	fingers = 3,
--  	direction = "up",
--  	action = function()
-- 		hl.exec_cmd("pkill wf-osk || wf-osk")
-- 	end,
-- })
