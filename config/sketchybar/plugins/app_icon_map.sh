case $@ in
"Docker" | "Docker Desktop")
	icon_result=":docker:"
	;;
"Infuse")
	icon_result=":playing:"
	;;
"WireGuard")
	icon_result=":vpn:"
	;;
"Final Cut Pro")
	icon_result=":final_cut_pro:"
	;;
"FaceTime")
	icon_result=":face_time:"
	;;
"Affinity Publisher")
	icon_result=":affinity_publisher:"
	;;
"Messages")
	icon_result=":messages:"
	;;
"VLC")
	icon_result=":vlc:"
	;;
"Thunderbird")
	icon_result=":thunderbird:"
	;;
"Notes")
	icon_result=":notes:"
	;;
"Things")
	icon_result=":things:"
	;;
"App Store")
	icon_result=":app_store:"
	;;
"zoom.us")
	icon_result=":zoom:"
	;;
"WhatsApp")
	icon_result=":whats_app:"
	;;
"Numbers")
	icon_result=":numbers:"
	;;
"Default")
	icon_result=":default:"
	;;
"Calendar")
	icon_result=":calendar:"
	;;
"Xcode")
	icon_result=":xcode:"
	;;
"Slack")
	icon_result=":slack:"
	;;
"System Settings")
	icon_result=":gear:"
	;;
"Discord")
	icon_result=":discord:"
	;;
"Firefox")
	icon_result=":firefox:"
	;;
"Mail")
	icon_result=":mail:"
	;;
"Safari")
	icon_result=":safari:"
	;;
"Keynote")
	icon_result=":keynote:"
	;;
"Spotlight")
	icon_result=":spotlight:"
	;;
"Music")
	icon_result=":music:"
	;;
"Alfred")
	icon_result=":alfred:"
	;;
"Pages")
	icon_result=":pages:"
	;;
"Affinity Designer")
	icon_result=":affinity_designer:"
	;;
"Affinity Photo")
	icon_result=":affinity_photo:"
	;;
"Obsidian")
	icon_result=":obsidian:"
	;;
"Reminders")
	icon_result=":reminders:"
	;;
"Preview")
	icon_result=":pdf:"
	;;
"1Password")
	icon_result=":one_password:"
	;;
"Finder")
	icon_result=":finder:"
	;;
"Podcasts")
	icon_result=":podcasts:"
	;;
"iTerm2" | "Terminal")
	icon_result=":terminal:"
	;;
"Weather")
	icon_result=":sun:"
	;;
"Sonos")
	icon_result=":volume_high:"
	;;
*)
	icon_result=":default:"
	;;
esac
echo $icon_result
