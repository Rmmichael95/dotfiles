#!/bin/bash

print_volume() {
	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	mute="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)\].*/\1/')"

	if [ "$mute" = "on" ]; then
		echo -e "${volume}%"
	else
		echo -e "Mute"
	fi
}

print_bat(){
	hash acpi || return 0
	onl="$(grep "on-line" <(acpi -V))"
	charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)"
	if test -z "$onl"
	then
		# suspend when we close the lid
		#systemctl --user stop inhibit-lid-sleep-on-battery.service
		echo -e "${charge}"
	else
		# On mains! no need to suspend
		#systemctl --user start inhibit-lid-sleep-on-battery.service
		echo -e "${charge}⚡"
	fi
}

print_date(){
	date "+%a %m-%d-%Y %T"
}

while true
do

	xsetroot -name "| VOL: $(print_volume) | BAT: $(print_bat)% | $(print_date) |"

	sleep 1

done
