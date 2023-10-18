#!/bin/bash

source "${HOME}/.config/zsh/personal_env"

weather_icon=(
	label.drawing=off
	icon.drawing=off
	padding_left=0
	padding_right=-5
	background.image.scale=0.0125
	background.image.drawing=on
	background.drawing=on
	click_script="/usr/bin/open https://www.meteoswiss.admin.ch/local-forecasts/${CITY}/${ZIP_CODE}.html#forecast-tab=detail-view"
)

weather_temperature=(
	icon.font="$FONT:Black:18.0"
	icon.padding_right=5
	update_freq=600
	script="$PLUGIN_DIR/weather.sh"
	click_script="/usr/bin/open https://www.meteoswiss.admin.ch/local-forecasts/${CITY}/${ZIP_CODE}.html#forecast-tab=detail-view"
)

sketchybar --add item weather_temperature right \
	--set weather_temperature "${weather_temperature[@]}" \
	--add item weather_icon right \
	--set weather_icon "${weather_icon[@]}"
