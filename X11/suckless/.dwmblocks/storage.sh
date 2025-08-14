#!/bin/bash

avaliable=$(df -h | grep n1p3 | awk '{print $4}')

echo "󰋊 $avaliable free | "
