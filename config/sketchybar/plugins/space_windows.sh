#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app; do
      for _ in $(seq 1 "$(echo "$INFO" | jq -r ".apps.\"$app\"")"); do
        icon_strip+=" $("$CONFIG_DIR"/plugins/app_icon_map.sh "$app")"
      done
    done <<<"${apps}"
  fi

  sketchybar --animate sin 10 --set space.$space label="$icon_strip"
fi
