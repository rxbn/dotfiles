#!/usr/bin/env bash

source "${HOME}/.config/zsh/personal_env"

WEATHER=$(curl -s "https://app-prod-ws.meteoswiss-app.ch/v1/plzDetail?plz=${ZIP_CODE}00")
TEMPERATURE=$(jq '.currentWeather.temperature' <<<"$WEATHER")
ICON=$(jq '.currentWeather.iconV2' <<<"$WEATHER")
BAR_ICON=$(${CONFIG_DIR}/plugins/weather_icon_map.sh "$ICON")

sketchybar --set $NAME label="${TEMPERATURE} °C" \
	--set $NAME \
	icon="$BAR_ICON"
