#!/bin/bash

used=$(free -h | grep Mem | awk '{print $3}')
total=$(free -h | grep Mem | awk '{print $2}')

echo " 󰍛 $used/$total | "
