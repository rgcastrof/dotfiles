#!/bin/bash

update_count=$(xbps-install -nuM | wc -l)

if [[ $update_count -eq 0 ]]; then
    echo ";"
else
    echo ";󱑤 $update_count  "
fi
