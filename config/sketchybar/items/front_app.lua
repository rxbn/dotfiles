local front_app = sbar.add("item", {
	label = {
		font = {
			style = "Black",
			size = 12,
		},
	},
	icon = {
		background = { drawing = true },
	},
	associated_display = "active",
	position = "left",
	padding_left = 0,
})

front_app:subscribe("front_app_switched", function(env)
	if env.INFO ~= "coreautha" then
		front_app:set({
			label = {
				string = env.INFO,
			},
			icon = {
				background = {
					image = "app." .. env.INFO,
				},
			},
		})
	end
end)
