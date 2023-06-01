case $@ in
"1")
	icon_result="􀆮" # sunny
	;;
"2" | "3" | "4" | "26")
	icon_result="􀇕" # mostly sunny
	;;
"5" | "35" | "55" | "105" | "135")
	icon_result="􀇃" # cloudy
	;;
"6" | "9" | "29" | "32" | "33")
	icon_result="􀇗" # rainy with clouds and sun
	;;
"7" | "10" | "31")
	icon_result="􀇑􀆬" # sleet with clouds and sun
	;;
"8" | "11" | "30" | "34")
	icon_result="􀇏􀆬" # snow with clouds and sun
	;;
"12" | "41")
	icon_result="􀇙" # thunderstorm with clouds and sun
	;;
"13" | "36" | "38")
	icon_result="􀇟􀆬" # thunderstorm with rain and sun
	;;
"14" | "17" | "64" | "67" | "114" | "117")
	icon_result="􀇇" # rainy
	;;
"15" | "18" | "21" | "65" | "68" | "71" | "115" | "118" | "121")
	icon_result="􀇑" # sleety
	;;
"16" | "19" | "22" | "66" | "69" | "72" | "116" | "119" | "122")
	icon_result="􀇏" # snowy
	;;
"20" | "70" | "120")
	icon_result="􀇉" # heavy rain
	;;
"23" | "24" | "25" | "73" | "74" | "75" | "123" | "124" | "125")
	icon_result="􀇟" # thunderstorm with rain
	;;
"27")
	icon_result="􀇋􀆬" # fog with sun
	;;
"28" | "78" | "128")
	icon_result="􀇋" # foggy
	;;
"37" | "39")
	icon_result="􀇏􀋦􀆬" # thunderstorm with snow and sun
	;;
"40" | "140")
	icon_result="􀇓" # thunderstorm with clouds
	;;
"42" | "142")
	icon_result="􀇏􀋦" # thunderstorm with snow
	;;
"51" | "101")
	icon_result="􀆺" # moon
	;;
"52" | "53" | "54" | "102" | "103" | "104" | "126")
	icon_result="􀇛" # moon with clouds
	;;
"56" | "59" | "106" | "109" | "129" | "132")
	icon_result="􀇝" # moon with rain
	;;
"133")
	icon_result="􀇉􀆺" # heavy rain with moon
	;;
"57" | "60" | "107" | "110" | "131")
	icon_result="􀇑􀆺" # sleet with moon
	;;
"58" | "61" | "108" | "111" | "130" | "134")
	icon_result="􀇏􀆺" # snow with moon
	;;
"62" | "112" | "141")
	icon_result="􀇡" # thunderstorm with moon
	;;
"63" | "113" | "136" | "138")
	icon_result="􀇟􀆺" # thunderstorm with rain and moon
	;;
"76" | "77" | "127")
	icon_result="􀇋􀆺" # fog with moon
	;;
"137" | "139")
	icon_result="􀇏􀋦􀆺" # thunderstorm with snow and moon
	;;
*)
	icon_result="􀃬"
	;;
esac
echo $icon_result
