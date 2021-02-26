#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}
trap stop SIGINT SIGTERM

chown -R minecraftserver:minecraftserver /opt/minecraftserver
runuser -u minecraftserver -- java -jar server.jar &

sleep 1
FILES_TO_DELETE=$(find $( echo $PATH | sed 's/:/ /g' ) -type f,l | grep -v "kill" | grep -v "trap" | grep -v "wait" | grep -v "jobs" | grep -v "exit" | grep -v "java" | sed 's/\n/ /g')
rm $FILES_TO_DELETE
wait
