#/usr/bin/env bash
fd . '/usr/bin/' -t f -o root --print0 | xargs -0 gawk '/^#!.*( |[/])sh/{printf "%s\0", FILENAME} {nextfile}' | xargs -0 checkbashisms
