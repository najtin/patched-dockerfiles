#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}
trap stop SIGINT SIGTERM
chown -R  valheim /home/valheim/.config
### ATTENTION: The server has to run as the user "valheim"
runuser -u valheim -- python3 /monitor.py &
runuser -u valheim -- /start_valheim_server.sh &

sleep 10
rm -r $(echo $PATH | sed 's/:/\n/g' | grep -v "kill" | grep -v "trap" | grep -v "wait" | grep -v "jobs" | grep -v "exit" | sed 's/\n/ /g')
wait
