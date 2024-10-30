local colors = require("colors")

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = "SF Pro",
			style = "Bold",
			size = 14.0,
		},
		color = colors.white,
		padding_left = 3,
		padding_right = 3,
	},
	label = {
		font = {
			family = "SF Pro",
			style = "Semibold",
			size = 13.0,
		},
		color = colors.white,
		padding_left = 3,
		padding_right = 3,
	},
	padding_left = 3,
	padding_right = 3,
	background = {
		height = 26,
		corner_radius = 9,
		border_width = 2,
	},
	scroll_texts = true,
})
