#!/bin/bash

# Start the first process
[ -n "$1" ] && [ "$1" != "null" ] && hysteria server -c $1 &

# Start the second process
[ -n "$2" ] && [ "$2" != "null" ] && xray run -config $2 &

# Start the third process
#caddy run --config $3 --adapter caddyfile &

# Start the fourth process
[ -n "$3" ] && [ "$3" != "null" ] && cloudflared tunnel run --token $3 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
