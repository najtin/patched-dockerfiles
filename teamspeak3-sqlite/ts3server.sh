#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}

trap stop SIGINT SIGTERM

docker build ./docker-files -t ts3server --no-cache
docker run \
 --rm \
 -p "9987:9987/udp" -p "10081:10081/tcp" -p "30033:30033/tcp" \
 --volume "ts3server-data:/opt/ts3server:rw" \
 --memory "200MB" \
 --memory-swap "0MB" \
 --cpus "0.1" \
 --hostname "ubuntu-ts3server" \
 --cap-drop ALL \
 --cap-add SETUID --cap-add SETGID --cap-add CHOWN --cap-add SETUID --cap-add DAC_OVERRIDE --cap-add FOWNER \
 ts3server \
 &
 
#readonly is not possible, because we want to delete all binaries and we can only do that at runtime
#once everything is started
wait