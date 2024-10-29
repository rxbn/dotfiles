local calendar = sbar.add("item", {
	icon = {
		font = {
			style = "Black",
			size = 12,
		},
	},
	padding_left = 15,
	update_freq = 1,
	position = "right",
})

calendar:subscribe({ "routine", "forced" }, function()
	local date = os.date("%a %d. %b")
	local time = os.date("%I:%M")
	calendar:set({ icon = { string = date }, label = { string = time } })
end)
