#!/bin/bash

#day=$(date +"%b %d %a")
time=$(date +"%I:%M%p" | tr '[:upper:]' '[:lower:]')

echo "| $time"
