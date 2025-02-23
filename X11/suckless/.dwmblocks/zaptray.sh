#!/bin/bash

zapId=$(flatpak ps | grep -m1 zapzap | awk '{print $3}')

if [ "$zapId" = "com.rtosta.zapzap" ]; then
    echo "  "
else
    echo ""
fi
