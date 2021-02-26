FROM ubuntu:20.04

ADD entrypoint.sh /entrypoint.sh
RUN (apt-get update && apt-get -y upgrade \
&& apt-get install -y openjdk-11-jre-headless \
&& adduser minecraftserver --gecos "" --disabled-password --uid 20001 --shell /bin/false \
&& mkdir -p /opt/minecraftserver \
&& chmod 700 /entrypoint.sh \
&& chown minecraftserver:minecraftserver /entrypoint.sh) > /dev/null

WORKDIR /opt/minecraftserver
ENTRYPOINT ["/bin/bash"]
CMD ["-c","/entrypoint.sh"]