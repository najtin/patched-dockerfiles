#!/bin/bash
set -e
(ulimit -f 2000; curl https://www.teamspeak.com/en/downloads/ -s --output /home/ts3server/download/site)
cat /home/ts3server/download/site | grep -o '"https://[^"<>]*teamspeak3-server_linux_amd64[^"<>]*\.tar\.bz2"' | head -n 1 | cut -c 2- | rev | cut -c 2- | rev > /home/ts3server/download/url
(ulimit -f 12000; curl "$(cat /home/ts3server/download/url)" -s --output /home/ts3server/download/teamspeak3-server_linux_amd64.tar.bz2)
cd /home/ts3server/unpack
cat /home/ts3server/download/teamspeak3-server_linux_amd64.tar.bz2 | tar -xvjf -