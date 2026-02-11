#!/bin/sh

if pgrep -x wvkbd-mobintl > /dev/null
then
  pkill -x wvkbd-mobintl
else
  wvkbd-mobintl -l  simple,specialpad
fi
