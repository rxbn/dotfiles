local colors = require("colors")

sbar.bar({
	height = 38,
	color = colors.bar.bg,
	shadow = false,
	position = "top",
	sticky = true,
	padding_left = 10,
	padding_right = 10,
	topmost = "window",
})
