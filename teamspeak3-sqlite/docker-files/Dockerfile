FROM ubuntu:20.04
ADD download.sh /download.sh
ADD entrypoint.sh /entrypoint.sh
ADD http-json.py /http-json.py
# ts3 has some undocumented dependencies, which is why we have to install ca-certificates libstdc++6
RUN (apt-get update && apt-get upgrade -y \
&& adduser ts3server --gecos "" --disabled-password  --uid 20000 --shell /bin/false \
&& apt-get install -y curl grep \
&& runuser -u ts3server mkdir /home/ts3server/unpack  /home/ts3server/download \
&& runuser -u ts3server bash /download.sh \
&& apt-get purge curl -y && apt-get autoremove -y \
&& mkdir -p /opt/build-ts3server/ \
&& mv /home/ts3server/unpack/teamspeak3-server_linux_amd64/* /opt/build-ts3server/ \ 
&& rm -rf /download.sh /home/ts3server/ \
&& apt-get -y install  ca-certificates libstdc++6 \
&& chmod 700 entrypoint.sh \
&& chown -R ts3server:ts3server /opt/build-ts3server/ \
# python proxy for json
&& apt-get install -y python3 python3-requests \
&& chmod 555 /http-json.py \
&& apt-get clean) > /dev/null

WORKDIR /opt/ts3server/
ENTRYPOINT ["/bin/bash"]
CMD ["-c","/entrypoint.sh"]