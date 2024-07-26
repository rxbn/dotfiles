#!/bin/bash

calendar=(
  icon.font="$FONT:Black:12.0"
  padding_left=15
  update_freq=1
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
