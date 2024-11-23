local colors = require("colors")

sbar.exec("aerospace list-workspaces --all --json", function(result)
	for _, workspace in ipairs(result) do
		local workspace_id = workspace["workspace"]

		local workspace_item = sbar.add("item", "workspace." .. workspace_id, {
			icon = {
				string = workspace_id,
				highlight_color = colors.red,
			},
			label = {
				drawing = false,
			},
		})

		workspace_item:subscribe("mouse.clicked", function()
			sbar.exec("aerospace summon-workspace " .. workspace_id)
		end)

		workspace_item:subscribe("aerospace_workspace_change", function(env)
			if env.FOCUSED_WORKSPACE == workspace_id then
				workspace_item:set({ icon = { highlight = true } })
			else
				workspace_item:set({ icon = { highlight = false } })
			end
		end)
	end
end)
