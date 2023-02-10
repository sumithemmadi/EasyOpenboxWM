#!/bin/bash

## Author  : Sumith Emmadi (sumithemmadi244@gmail.com)
## Mail    : sumithemmadi244@gmail.com
## Github  : @sumithemmadi
## Twitter : @sumithemmadi


## ANSI Colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"

## Reset terminal colors
reset_color() {
	printf '\033[37m'
}

## Script Termination
exit_on_signal_SIGINT() {
    { printf "${RED}\n\n%s\n\n" "[!] Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "${RED}\n\n%s\n\n" "[!] Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

pkgs=("xorg xorg-font-util xorg-xrdb xorg-xdm  xfce4-settings xfce4-terminal \
openbox openbox-session obconf xarchiver dbus desktop-file-utils elinks gtk2 gtk3 man \
zsh git  vim nano curl wget jq xarchiver firefox imagemagick geany alacritty gedit \
bc bmon calc calcurse feh htop scrot mpc mpd mutt ncmpcpp neofetch  openssl leafpad \
xmlstarlet xbitmaps ranger  xcompmgr nitrogen brightnessctl alsa-utils\
polybar ranger rofi startup-notification thunar  flameshot")

# echo $pkgs
sudo pacman -S $pkgs

cd ~/
git clone https://github.com/sumithemmadi/EasyOpenboxWM.git
cd EasyOpenboxWM

 configs=($(ls -A $(pwd)/files))
  for file in "${configs[@]}"; do
   if [[ -f "$HOME/$file" || -d "$HOME/$file" ]]; then
    { mv -u ${HOME}/${file}{,.old}; }  
   fi
  done



 configs=($(ls -A $(pwd)/files))
 for _config in "${configs[@]}"; do
   cp -rf $(pwd)/files/$_config $HOME;
 done