#!/bin/bash
feh --bg-fill --no-fehbg --randomize /home/dasea/Pictures/wallpapers/*
if [[ $? -eq 0 ]]; then
  return "OK"
else
  return "Error"
fi

