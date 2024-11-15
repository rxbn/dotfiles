local colors = require("colors")
local icons = require("icons")

local yabai = sbar.add("item", {
	icon = {
		width = 0,
		font = {
			style = "Bold",
			size = 16,
		},
	},
	label = {
		width = 0,
	},
	position = "left",
	associated_display = "active",
	padding_left = 0,
	padding_right = 0,
})

local function update_display(icon, label, color)
	yabai:set({ icon = { color = color } })
	if label == "" then
		yabai:set({ label = { width = 0 } })
	else
		yabai:set({ label = { string = label, width = 40 } })
	end
	if icon == "" then
		yabai:set({ icon = { width = 0 } })
	else
		yabai:set({ icon = { string = icon, width = 30 } })
	end
end

local function window_state()
	local icon = ""
	local label = ""
	local color = colors.bar.border

	sbar.exec("yabai -m query --windows --window", function(window)
		if window["is-floating"] == true then
			icon = icons.yabai.float
			color = colors.red
		elseif window["has-fullscreen-zoom"] == true then
			icon = icons.yabai.fullscreen_zoom
			color = colors.green
		elseif window["has-parent-zoom"] == true then
			icon = icons.yabai.parent_zoom
			color = colors.blue
		elseif window["stack-index"] > 0 then
			sbar.exec("yabai -m query --windows --window stack.last", function(last_stack)
				local last_stack_index = last_stack["stack-index"]
				icon = icons.yabai.stack
				label = "[" .. window["stack-index"] .. "/" .. last_stack_index .. "]"
				color = colors.magenta
				update_display(icon, label, color)
			end)
			return
		end

		update_display(icon, label, color)
	end)
end

yabai:subscribe("window_focus", window_state)
