#!/usr/bin/env sh

URL="$(wl-paste | bemenu --prompt "Enter URL >" --line-height 30 --counter "always" --tb "#15191c" --tf "#eb4d4b" --fb "#15191c" --ff "#d3c6aa" --nb "#15191c" --nf "#4b565c" --hb "#15191c" --hf "#d3c6aa" --fbb "#15191c" --fbf "#d3c6aa" --sb "#15191c" --sf "#d3c6aa" --ab "#15191c" --af "#4b565c" --bdr "#4b565c")"

lighthouse $URL --view
