#!/usr/bin/env bash

source "${HOME}/personal/dotfiles/personal/config/zsh/personal_env"

WEATHER=$(curl --max-time 2 --silent --retry 3 --retry-delay 1 --retry-connrefused "https://app-prod-ws.meteoswiss-app.ch/v1/plzDetail?plz=${ZIP_CODE}00")

if [[ -n "$WEATHER" ]]; then
  TEMPERATURE=$(jq '.currentWeather.temperature' <<<"$WEATHER")
  ICON=$(jq '.currentWeather.iconV2' <<<"$WEATHER")
else
  TEMPERATURE="N/A"
  ICON=""
fi

sketchybar -m --set weather_temperature label="${TEMPERATURE} °C" \
  --set weather_icon \
  background.image="${HOME}/Nextcloud/Photos/meteoswiss-weather-icons/png/${ICON}.png" \
  background.color=0x00000000
