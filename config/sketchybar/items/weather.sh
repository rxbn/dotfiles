#!/bin/bash

source "${HOME}/.config/zsh/personal_env"

weather=(
	icon.font="$FONT:Black:18.0"
	icon.padding_right=5
	update_freq=600
	script="$PLUGIN_DIR/weather.sh"
	click_script="/usr/bin/open https://www.meteoswiss.admin.ch/local-forecasts/${CITY}/${ZIP_CODE}.html#forecast-tab=detail-view"
)

sketchybar --add item weather right \
	--set weather "${weather[@]}"
