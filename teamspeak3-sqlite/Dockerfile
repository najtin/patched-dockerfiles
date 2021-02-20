FROM ubuntu:20.04
# ts3 has some undocumented dependencies, which is why we have to install ca-certificates libstdc++6
RUN apt-get update && apt-get upgrade -y
ADD download.sh /download.sh
ADD entrypoint.sh /entrypoint.sh
RUN adduser ts3server --gecos "" --disabled-password \
&& apt-get install -y curl grep \
&& runuser -u ts3server mkdir /home/ts3server/unpack  /home/ts3server/download \
&& runuser -u ts3server bash /download.sh \
&& apt-get purge curl -y && apt-get autoremove -y \
&& mkdir -p /opt/build-ts3server/ \
&& mv /home/ts3server/unpack/teamspeak3-server_linux_amd64/* /opt/build-ts3server/ \ 
&& rm -rf /download.sh /home/ts3server/ \
&& apt-get -y install  ca-certificates libstdc++6 \
&& chmod 700 entrypoint.sh \
&& chown -R ts3server:ts3server /opt/build-ts3server/ 

VOLUME /opt/ts3server
#voice
EXPOSE 9987/udp 
#server query
EXPOSE 10011
#file transmission
EXPOSE 30033 

WORKDIR /opt/ts3server/
ENTRYPOINT ["/bin/bash"]
CMD ["-c","/entrypoint.sh"]