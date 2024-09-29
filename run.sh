#! /bin/sh
set -x

./start_project.sh &
PID=$!

echo $PID

sleep 3

# THIS DOES NOT WORK
# Check this: https://unix.stackexchange.com/questions/124127/kill-all-descendant-processes
pkill -9 -P $PID > /dev/null
