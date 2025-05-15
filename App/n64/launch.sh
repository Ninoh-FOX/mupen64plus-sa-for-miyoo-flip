#!/bin/sh
cd $(dirname "$0")
APPDIR="$(dirname "$0")"

HOME="$APPDIR"

cd $HOME
LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"

echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1416000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu2/online

keykill mupen64plus
./mupen64plus "$1" 2>&1 | tee $HOME/log.txt

sync
