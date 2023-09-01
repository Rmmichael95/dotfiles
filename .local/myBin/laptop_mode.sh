#!/usr/bin/env sh

show() {
    echo '\_SB.PCI0.LPC0.EC0.PFMM' | tee /proc/acpi/call
    state=$(cat /proc/acpi/call | cut -d '' -f1)
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    case $state in
        "0x0") echo "Battery Saving";;
        "0x1") echo "Extreme Performance";;
        "0x2") echo "Intellegent Cooling";;
    esac
}

battery() {
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | tee /proc/acpi/call
    echo powersave | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

performance(){
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' | tee /proc/acpi/call
    echo performance | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

ondemand() {
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | tee /proc/acpi/call
    echo ondemand | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

conservative() {
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' | tee /proc/acpi/call
    echo conservative | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

scheduler() {
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | tee /proc/acpi/call
    echo scheduler | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

rapid() {
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' | tee /proc/acpi/call
    echo conservative | tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
}

case "$1" in
    "-b") battery;;
    "-p") performance;;
    "-o") ondemand;;
    "-c") conservative;;
    "-u") scheduler;;
    "-r") rapid;;
    "--help") show;;
esac
