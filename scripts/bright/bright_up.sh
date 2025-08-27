#!/bin/bash
current=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)

((incr = max * 5 / 100))

(( current += incr ))

if [ $current -gt $max ]; then
	(( current = max ))
fi

echo $current | doas tee /sys/class/backlight/intel_backlight/brightness > /dev/null
