#!/bin/bash

## Dirs #############################################
polybar_path="$HOME/.config/polybar"
rofi_path="$HOME/.config/rofi"
terminal_path="$HOME/.config/xfce4/terminal"
geany_path="$HOME/.config/geany"
openbox_path="$HOME/.config/openbox"

# wallpaper ---------------------------------
feh --bg-scale $HOME/.local/share/backgrounds/Forest.jpg

# polybar ---------------------------------
sed -i -e 's/STYLE=.*/STYLE="forest"/g' $polybar_path/launch.sh
sed -i -e 's/font-0 = .*/font-0 = "Terminus:Medium:size=9;2"/g' $polybar_path/forest/config.ini

cat > $polybar_path/forest/colors.ini << _EOF_
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;;
;;	   ______      __               
;;	  / ____/___  / /___  __________
;;	 / /   / __ \/ / __ \/ ___/ ___/
;;	/ /___/ /_/ / / /_/ / /  (__  ) 
;;	\____/\____/_/\____/_/  /____/  
;;
;;  Created By Aditya Shakya @adi1090x
;;
;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

[color]

BG = #212B30
BGA = #5C6F7B
FG = #C4C7C5
AC = #4DD0E1

BLACK = #000000
WHITE = #FFFFFF
RED = #EC7875
GREEN = #61C766
YELLOW = #FDD835
BLUE = #42A5F5
PURPLE = #BA68C8
CYAN = #4DD0E1
TEAL = #00B19F
AMBER = #FBC02D
ORANGE = #E57C46
BROWN = #AC8476
GRAY = #8C8C8C
BLUEGRAY = #6D8895
PINK = #EC407A
LIME = #B9C244
INDIGO = #6C77BB

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
_EOF_

# relaunch polybar
$polybar_path/launch.sh

# rofi ---------------------------------
sed -i -e 's/STYLE=.*/STYLE="forest"/g' "$rofi_path/bin/mpd" "$rofi_path/bin/network" "$rofi_path/bin/battery"
sed -i -e 's/DIR=.*/DIR="forest"/g' "$rofi_path/bin/launcher" "$rofi_path/bin/powermenu"
sed -i -e 's/STYLE=.*/STYLE="launcher"/g' "$rofi_path/bin/launcher"
sed -i -e 's/STYLE=.*/STYLE="powermenu"/g' "$rofi_path/bin/powermenu"
sed -i -e 's/font:.*/font:				 	"Terminus Medium 9";/g' "$rofi_path/forest/font.rasi"

cat > $rofi_path/forest/colors.rasi << _EOF_
/* Color-Scheme */

* {
    BG:    #212B30ff;
    BGA:   #263238ff;
    FG:    #C4C7C5ff;
    BDR:   #4DD0E1ff;
    SEL:   #4DD0E1ff;
    UGT:   #EC407Aff;
	IMG:   #EC407Aff;
	ON:    #61C766ff;
	OFF:   #EC7875ff;
}
_EOF_

sed -i -e 's/font:.*/font:				 	"Terminus Medium 9";/g' "$rofi_path/dialogs/askpass.rasi" "$rofi_path/dialogs/confirm.rasi"
sed -i -e 's/border:.*/border:					0px;/g' "$rofi_path/dialogs/askpass.rasi" "$rofi_path/dialogs/confirm.rasi"
cat > $rofi_path/dialogs/colors.rasi << _EOF_
/* Color-Scheme */

* {
    BG:    #212B30ff;
    FG:    #C4C7C5ff;
    BDR:   #EC407Aff;
}
_EOF_

# Terminal ---------------------------------
sed -i -e 's/FontName=.*/FontName=Terminus Medium 9/g' $terminal_path/terminalrc
sed -i -e 's/ColorPalette=.*/ColorPalette=#263640;#EC7875;#61C766;#FDD835;#42A5F5;#BA68C8;#4DD0E1;#bfbaac;#4a697d;#FB8784;#70D675;#FFE744;#51B4FF;#C979D7;#5CDFF0;#fdf6e3/g' $terminal_path/terminalrc
sed -i -e 's/ColorForeground=.*/ColorForeground=#C4C7C5/g' $terminal_path/terminalrc
sed -i -e 's/ColorBackground=.*/ColorBackground=#222D32/g' $terminal_path/terminalrc
sed -i -e 's/ColorCursor=.*/ColorCursor=#afbfbf/g' $terminal_path/terminalrc

# geany ---------------------------------
sed -i -e 's/color_scheme=.*/color_scheme=forest.conf/g' "$geany_path"/geany.conf
sed -i -e 's/editor_font=.*/editor_font=Terminus Medium 9/g' "$geany_path"/geany.conf

# gtk theme, icons and fonts ---------------------------------
xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Nokto-Eta"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Hybrid"
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Hybrid"
xfconf-query -c xsettings -p /Gtk/FontName -s "Terminus Medium 9"

# openbox ---------------------------------
obconfig () {
	namespace="http://openbox.org/3.4/rc"
	config="$openbox_path/rc.xml"
	theme="forest"
	layout="CLM"
	font="Terminus"
	fontsize="9"

	# Theme
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:name' -v "$theme" "$config"

	# Title
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:titleLayout' -v "$layout" "$config"

	# Fonts
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveWindow"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveWindow"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuHeader"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="MenuItem"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:weight' -v Bold "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="ActiveOnScreenDisplay"]/a:slant' -v Normal "$config"

	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:name' -v "$font" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:size' -v "$fontsize" "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:weight' -v Normal "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:theme/a:font[@place="InactiveOnScreenDisplay"]/a:slant' -v Normal "$config"

	# Margins
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:top' -v 0 "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:bottom' -v 10 "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:left' -v 10 "$config"
	xmlstarlet ed -L -N a="$namespace" -u '/a:openbox_config/a:margins/a:right' -v 10 "$config"
}

obconfig && openbox --reconfigure

# Other ---------------------------------
sed -i -e 's/progressbar_color = .*/progressbar_color = "black"/g' $HOME/.ncmpcpp/config

## EOF #############################################
