#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
	if [ "$INFO" != "coreautha" ]; then
		sketchybar --set $NAME label="$INFO" icon.background.image="app.$INFO"
	fi
fi
