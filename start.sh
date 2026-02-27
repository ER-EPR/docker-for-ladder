#!/bin/bash

echo "[$(date)] Starting scripts with params: P1=$1, P2=$2, P3=$3"

# Start the first process
if [ -n "$1" ] && [ "$1" != "null" ]; then
    echo "Starting Hysteria..."
    hysteria server -c "$1" &
else
    echo "Skipping Hysteria (param is null or empty)"
fi

# Start the second process
if [ -n "$2" ] && [ "$2" != "null" ]; then
    echo "Starting Xray..."
    xray run -config "$2" &
else
    echo "Skipping Xray (param is null or empty)"
fi

# Start the fourth process (Cloudflared)
if [ -n "$3" ] && [ "$3" != "null" ]; then
    echo "Starting Cloudflared..."
    cloudflared tunnel run --token "$3" &
else
    echo "Skipping Cloudflared (param is null or empty)"
fi

# 检查是否有后台任务启动
if [ $(jobs -r | wc -l) -gt 0 ]; then
    echo "Waiting for processes..."
    wait -n
else
    echo "Error: No processes started. Exiting."
    exit 1
fi

exit $?
# Start the first process
#[ -n "$1" ] && [ "$1" != "null" ] && hysteria server -c "$1" &

# Start the second process
#[ -n "$2" ] && [ "$2" != "null" ] && xray run -config "$2" &

# Start the third process
#caddy run --config $3 --adapter caddyfile &

# Start the fourth process
#[ -n "$3" ] && [ "$3" != "null" ] && cloudflared tunnel run --token "$3" &

# Wait for any process to exit
#wait -n

# Exit with status of process that exited first
#exit $?
