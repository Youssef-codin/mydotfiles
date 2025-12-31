#!/usr/bin/env bash
CONFIG="$HOME/.config/wayvnc/conf"
[ -f "$CONFIG" ] || echo "Config file not found at $CONFIG"
exec wayvnc -C "$CONFIG"
