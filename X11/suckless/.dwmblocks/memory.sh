#!/bin/bash

# used=$(free -h | grep Mem | awk '{print $3}')
# total=$(free -h | grep Mem | awk '{print $2}')
perc_used=$(free | grep Mem | awk '{printf("%.2f%%\n", $3/$2 * 100)}')

# echo " 󰍛 $used/$total | "
echo "   $perc_used | "
