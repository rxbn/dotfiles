local secrets = require("secrets")

local weather = sbar.add("item", {
	background = {
		drawing = true,
		image = {
			scale = 0.0125,
		},
	},
	label = {
		padding_left = 25,
	},
	position = "right",
	update_freq = 600,
})

local function update_weather()
	sbar.exec(
		"curl --max-time 2 --silent --retry 3 --retry-delay 1 --retry-connrefused https://app-prod-ws.meteoswiss-app.ch/v1/plzDetail?plz="
			.. secrets.zip_code
			.. "00",
		function(result)
			local weather_temp = result.currentWeather.temperature .. " °C"
			local weather_icon = result.currentWeather.iconV2

			weather:set({
				label = { string = weather_temp },
				background = {
					image = "~/Nextcloud/Photos/meteoswiss-weather-icons/png/" .. weather_icon .. ".png",
				},
			})
		end
	)
end

weather:subscribe({ "routine", "forced" }, update_weather)

weather:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "left" then
		sbar.exec(
			"open https://www.meteoswiss.admin.ch/local-forecasts/"
				.. secrets.city
				.. "/"
				.. secrets.zip_code
				.. ".html#forecast-tab=detail-view"
		)
	elseif env.BUTTON == "right" then
		update_weather()
	end
end)
