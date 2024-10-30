local colors = require("colors")
local app_icons = require("items.app_icons")

local function mouse_click(env)
	if env.BUTTON == "right" then
		sbar.exec("yabai -m space --destroy " .. env.SID)
	else
		sbar.exec("yabai -m space --focus " .. env.SID)
	end
end

local function space_selection(env)
	local color = env.SELECTED == "true" and colors.grey or colors.bg2

	sbar.set(env.NAME, {
		icon = { highlight = env.SELECTED },
		label = { highlight = env.SELECTED },
		background = { border_color = color },
	})
end

for i = 1, 9, 1 do
	local space = sbar.add("space", "space." .. i, {
		associated_space = i,
		icon = {
			string = i,
			padding_left = 10,
			padding_right = 10,
			highlight_color = colors.red,
		},
		padding_left = 2,
		padding_right = 2,
		label = {
			padding_right = 20,
			color = colors.grey,
			highlight_color = colors.white,
			font = {
				family = "sketchybar-app-font",
				style = "Regular",
				size = 16.0,
			},
			y_offset = -1,
		},
		background = {
			color = colors.bg1,
			border_color = colors.bg2,
		},
	})

	space:subscribe("space_change", space_selection)
	space:subscribe("mouse.clicked", mouse_click)
end

local space_creator = sbar.add("item", {
	padding_left = 10,
	padding_right = 8,
	icon = {
		color = colors.white,
		string = "􀆊",
		font = {
			style = "Heavy",
			size = 16.0,
		},
	},
	label = { drawing = false },
	associated_display = "active",
})

space_creator:subscribe("mouse.clicked", function()
	sbar.exec("yabai -m space --create")
end)

space_creator:subscribe("space_windows_change", function(env)
	local space = env.INFO.space
	local apps = env.INFO.apps

	local icon_strip = " "
	for app, no in pairs(apps) do
		for _ = 1, no, 1 do
			icon_strip = icon_strip .. " " .. app_icons[app]
		end
	end

	sbar.animate("sin", 10.0, function()
		sbar.set("space." .. space, { label = { string = icon_strip } })
	end)
end)