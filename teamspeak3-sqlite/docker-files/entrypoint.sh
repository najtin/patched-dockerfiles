#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}
trap stop SIGINT SIGTERM
chown -R  ts3server /opt/ts3server/
### ATTENTION: The server has to run as the user "ts3server"
runuser -u ts3server -- cp -r /opt/build-ts3server/* /opt/ts3server/
runuser -u ts3server /http-json.py &
runuser -u ts3server /opt/ts3server/ts3server license_accepted=1 &

sleep 1
rm -r $(echo $PATH | sed 's/:/\n/g' | grep -v "kill" | grep -v "trap" | grep -v "wait" | grep -v "jobs" | grep -v "exit" | sed 's/\n/ /g')
wait