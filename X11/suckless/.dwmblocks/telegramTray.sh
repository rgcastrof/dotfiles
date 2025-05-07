#!/bin/bash

telegramId=$(flatpak ps | grep -m1 telegram | awk '{print $3}')

if [ "$telegramId" = "org.telegram.desktop" ]; then
    echo "   "
else
    echo ""
fi
