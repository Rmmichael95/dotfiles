#!/bin/env zsh

print_time(){
    echo $(date "+%a %H:%M")
}

print_volume() {
    AUDIO="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
    NOTMUTED="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)\].*/\1/')"

    if [ "$NOTMUTED" = "on" ]; then
        case "$AUDIO" in
            0) echo " 🔇    $AUDIO%" ;;
            [1-9]) echo " 🔈    $AUDIO%" ;;
            1?|2?|3?) echo "🔈  $AUDIO%" ;;
            4?|5?|6?) echo "🔉  $AUDIO%" ;;
            7?|8?|9?) echo "🔊  $AUDIO%" ;;
            *) echo "🔊$AUDIO%" ;;
        esac
    else
        echo -e "🔇 Mute"
    fi
}

print_bat(){
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    case "$battery_status" in
        Charging)
            # On mains! no need to suspend
            # systemctl --user start inhibit-lid-sleep-on-battery.service
            # echo -e "${charge}⚡"
            echo "⚡ ${battery_percent}%";;
        Discharging)
            # suspend when we close the lid
            # systemctl --user stop inhibit-lid-sleep-on-battery.service
            # echo -e "${charge}"
            echo "🔋 ${battery_percent}%"
    esac
}



while true; do
    xsetroot -name " $(print_time)                                                                                                                                                        $(print_bat) $(print_volume)        "
    sleep 1
done
