#!/bin/bash
# fuzzy_win launches the script from param in a centered window
alacritty --class SkimDmenu --title SkimDmenu --option window.dimensions.columns=60 window.dimensions.lines=5 --command $1
