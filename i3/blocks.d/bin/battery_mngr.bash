#!/usr/bin/env bash

#  TODO: Optimize

status="$(cat /sys/class/power_supply/BAT0/status)"
capacity="$(cat /sys/class/power_supply/BAT0/capacity)"

cl_green="#0ceb3c"
cl_orange="#ef9f10"
cl_red="#ff0000"

if [ "$status" = "Charging" ]; then
  icon=
  state"${cl_green}"
else
  if [ "$capacity" -ge 90 ]; then 
    icon=
    state="${cl_green}"
  elif [ "$capacity" -ge 75 ]; then
    icon=
    state="${cl_orange}"
  elif [ "$capacity" -ge 50 ]; then 
    icon=
    state="${cl_orange}"
  elif [ "$capacity" -ge 25 ]; then
    icon=
    state="${cl_red}"
  else 
    icon=
    state="${cl_red}"
  fi
fi

echo " <span color='$state' >${icon}</span>\
    <span color='#f0ffff'>${capacity}%</span> "

if [ "$BLOCK_BUTTON" == "1" ]; then
  notify-send "Battery Info" "Status: $status\nCharge: $capacity%"
fi
