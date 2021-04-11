FROM ubuntu:20.04
ARG username
ARG password
ADD entrypoint.sh /entrypoint.sh
ADD monitor.py /monitor.py
RUN (chown root:root /entrypoint.sh \
&& chmod 766 /entrypoint.sh \
&& chmod 555 /monitor.py \
&& dpkg --add-architecture i386 \
&& apt-get -q -y update \
&& apt-get -q -y upgrade \
&& echo steam steam/question select "I AGREE" | debconf-set-selections \
&& echo steam steam/license note '' | debconf-set-selections \
&& DEBIAN_FRONTEND=noninteractive apt-get install -q -y lib32gcc1 steamcmd python3 python3-pip ca-certificates \
&& adduser valheim --gecos "" --disabled-password --uid 20002 --shell /bin/false \
&& runuser -u valheim -- mkdir -p /home/valheim/valheim \
&& cd /home/valheim/valheim \
&& (runuser -u valheim -- /usr/games/steamcmd +@sSteamCmdForcePlatformType linux +login "$username" "$password" +quit) || true  \
&& (runuser -u valheim -- /usr/games/steamcmd +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir /home/valheim/valheim +app_update 896660 validate +quit) || true \
&& (runuser -u valheim -- pip3 install python-a2s) \
)

WORKDIR /home/valheim/valheim
ENTRYPOINT ["/bin/bash"]
CMD ["-c","/entrypoint.sh"]
