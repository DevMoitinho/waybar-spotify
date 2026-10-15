#!/usr/bin/env bash

export PATH="$PATH:$HOME/.local/bin:$HOME/miniforge3/bin:$HOME/miniconda3/bin:$HOME/anaconda3/bin"

for cmd in zscroll playerctl; do
    command -v "$cmd" >/dev/null || { echo "faltando: $cmd"; exit 1; }
done

exec zscroll -p "  " --delay 0.1 \
    --length 10 \
    --match-command "playerctl -p spotify status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--before-text '⏸' --scroll 0" \
    --update-interval 1 \
    --update-check true \
    "playerctl -p spotify metadata --format '{{title}} - {{artist}}' 2>/dev/null" 2>/dev/null
