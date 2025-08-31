#!/bin/bash

# avaliable=$(df -h | grep n1p3 | awk '{print $4}')
perc_used=$(df -h / | sed -n '2p' | awk '{print $5}')

# echo "󰋊 $avaliable free | "
echo "󰋊 $perc_used | "
