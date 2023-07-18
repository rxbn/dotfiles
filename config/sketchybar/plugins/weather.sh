#!/usr/bin/env bash

source "${HOME}/.config/zsh/personal_env"

WEATHER=$(curl --max-time 2 --silent "https://app-prod-ws.meteoswiss-app.ch/v1/plzDetail?plz=${ZIP_CODE}00")
TEMPERATURE=$(jq '.currentWeather.temperature' <<<"$WEATHER")
ICON=$(jq '.currentWeather.iconV2' <<<"$WEATHER")

sketchybar -m --set weather_temperature label="${TEMPERATURE} °C" \
	--set weather_icon \
	background.image="${HOME}/Nextcloud/Photos/meteoswiss-weather-icons/png/${ICON}.png" \
	background.color=0x00000000
