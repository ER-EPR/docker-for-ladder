#!/bin/bash

# Start the first process
hysteria server -c $1 &

# Start the second process
xray run -config $2 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
