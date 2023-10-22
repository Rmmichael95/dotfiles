#!/usr/bin/python
#add script to cronjob or soy-d timer

import os, subprocess

os.system("notify-send 'Running: coordinate.py'")
COR = subprocess.check_output("/usr/lib/geoclue-2.0/demos/where-am-i | rg 'Latitude:|Longitude:' | awk '{print $2}' | sed 's/.$//'", shell=True)
COR = str(COR, 'utf-8')
LAT = COR.split('\n')[0].strip()
LON = COR.split('\n')[1].strip()
COR = f"{LAT},{LON}"


os.system("echo "" /home/ryanm/.config/eww/scripts/coordinate.txt")
f = open('/home/ryanm/.config/eww/scripts/coordinate.txt', 'w')
f.write(COR)
os.system("notify-send 'Done: coordinate.py'")
