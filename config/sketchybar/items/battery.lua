local colors = require("colors")

local battery = sbar.add("item", "battery", {
	position = "right",
	icon = {
		drawing = false,
		string = "􀛪 !",
		font = {
			size = 20,
		},
		color = colors.red,
	},
	label = { drawing = false },
	padding_right = 10,
	update_freq = 120,
})

battery:subscribe({ "routine", "forced" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local _, _, charge = batt_info:find("(%d+)%%")

		if tonumber(charge) <= 10 then
			battery:set({ icon = { drawing = true } })
		end
	end)
end)
