#!/bin/sh
cd $(dirname "$0")
APPDIR="$(dirname "$0")"

HOME="$APPDIR"

cd $HOME
PATH="/mnt/SDCARD/miyoo355/bin:$PATH"
LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"

echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1416000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu2/online

resolution=$(fbset | grep 'geometry' | awk '{print $2,$3}')
width=$(echo $resolution | awk '{print $1}')
height=$(echo $resolution | awk '{print $2}')

cfg_path="$HOME/.config/mupen64plus/mupen64plus.cfg"
sed -i "/^\s*ScreenWidth\s*=/c\ScreenWidth = $width" "$cfg_path"
sed -i "/^\s*ScreenHeight\s*=/c\ScreenHeight = $height" "$cfg_path"

gptokeyb -k "mupen64plus" &

./mupen64plus "$1"

sync
pkill -9 gptokeyb

echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu3/online
