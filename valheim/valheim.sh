#!/bin/bash
set -e
stop() {
    trap " " SIGINT SIGTERM
    kill -s sigint $(jobs -p) 
    wait
    exit 0
}

trap stop SIGINT SIGTERM

. credentials.sh
docker build ./docker-files -t valheim --no-cache --build-arg username=$username --build-arg password=$password
docker run \
 --rm \
 -p "2456:2456/udp" -p "2456:2456/tcp" -p "10093:10093/tcp" \
 --volume "valheim-data:/home/valheim/.config/unity3d/IronGate/Valheim/worlds:rw" \
 --memory "8GB" \
 --memory-swap "0MB" \
 --cpus "3.0" \
 --hostname "ubuntu-valheim" \
 --cap-drop ALL \
 --cap-add SETUID --cap-add SETGID --cap-add CHOWN --cap-add SETUID --cap-add DAC_OVERRIDE --cap-add FOWNER \
 valheim \
 &
 
#readonly is not possible, because we want to delete all binaries and we can only do that at runtime
#once everything is started
wait
