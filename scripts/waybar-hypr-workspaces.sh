#!/usr/bin/env bash
# outputs a simple single-line label string for waybar custom module
# shows workspace id for normal, or the name without "special:" for special workspaces

out=$(hyprctl -j workspaces 2>/dev/null | jq -r '
  sort_by(.id) |
  map(
    if (.name|startswith("special:")) then
      (.name|sub("^special:";"")) as $n | if .id == .monitorID then $n else $n end
    else
      (.id|tostring)
    end
  )
  | join("  ")
')

# Fallback if hyprctl fails
if [ -z "$out" ]; then
  echo "{\"text\":\"workspaces\"}"
else
  # Waybar expects JSON when return-type=json and format={text}
  printf '{"text":"%s"}' "$out"
fi
