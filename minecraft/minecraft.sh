#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}

trap stop SIGINT SIGTERM

docker build ./docker-files -t minecraftserver --no-cache
docker run \
 --rm \
 -p "25565:25565/tcp" -p "25566:10081/tcp" \
 --volume "minecraftserver-data:/opt/minecraftserver:rw" \
 --memory "1200MB" \
 --memory-swap "0MB" \
 --cpus "1" \
 --hostname "ubuntu-minecraftserver" \
 --cap-drop ALL \
 --cap-add SETUID --cap-add SETGID --cap-add CHOWN --cap-add SETUID --cap-add DAC_OVERRIDE --cap-add FOWNER \
 minecraftserver \
 &

#readonly is not possible, because we want to delete all binaries and we can only do that at runtime
#once everything is started
wait